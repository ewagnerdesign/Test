module FD
  module Metadata
    class Form
      attr_reader :columns, :controls, :metadata, :connections
      attr_accessor :form_id
      attr_accessor :form_version

      def initialize(data)
        #Decode form metadata JSON
        @metadata = ActiveSupport::JSON.decode(data)
        #TODO: Validate the whole JSON structure
        @columns = []
        @raw_controls =[]

        #Replace control data structure with Metadata object
        @metadata['controls'] = @metadata['controls'].inject([]) do |result, control|
          #Column control
          begin
            ctrl = Column.new(control['group'])
            @columns.push(ctrl)
            result.push(ctrl)
          end unless control['group'].nil?
          #Raw control
          begin
            ctrl = Field.new(control['control'])
            @raw_controls.push(ctrl)
            result.push(ctrl)
          end unless control['control'].nil?
          result
        end

        #General control list
        @controls = []

        #Add controls within columns to the controls list
        @controls = @raw_controls
        @columns.each do |column|
          @controls += column.controls
        end

        @form_id = @metadata['form']['formId']
        @form_version = @metadata['form']['formVersion']

        # Collect all connections
        @connections = @metadata['connections']
#        @connections = @metadata['connections'].collect do |connection|
#           connection = Connection.new(connection)
#
#           # prepare controls
#           %w(sources targets).each do |name|
#             connection.send(name).map! do |item|
#                item.control = find_control_by_id(item.id)
#                item
#             end
#           end
#
#           connection
#        end unless @metadata['connections'].nil?

      end

      #Update form id
      def form_id=(value)
        @form_id = @metadata['form']['formId'] = value
      end

      #Set form version id into metadata
      def form_version=(value)
        @form_version = @metadata['form']['formVersion'] = value
      end

      #Access to meadata tree
      def metatree
        metadata['controls']
      end

      #Covert data structure into hash
      def to_hash
        #Set virtual column and column cells ids
        max_id = @controls.max{|a,b| a.control_id <=> b.control_id }.try(:control_id) || 1
        @columns.each do |column|
          column.control_id = max_id+= 1
        end

        #Prepare connections ids
        convert_connections

        #Prevent inplace object chane to keep its state
        tohash = @metadata.clone
        #Call appropriate to_hash method for all available controls
        tohash['controls'].map!(&:to_hash)
        #Call appropriate to_hash method for all available connections
        #tohash['connections'].map!(&:to_hash) unless tohash['connections'].nil?
        tohash
      end

      #Convert data structure into JSON
      def to_json
        self.to_hash.to_json
      end

      private

      def find_control_by_id(object_id)
        controls = @controls.select {|control| control.internal_id == object_id['internalId']}
        #Find in columns
        controls = @columns.select {|control| control.internal_id == object_id['internalId']} if controls.empty?

        raise "control not found with id " + object_id.to_json if controls.empty?

        controls.first
      end

      def convert_connections
        @metadata['connections'].map! do |connection|

          begin
            %w(targets sources).each do |path|
              connection[path].map! do |entry|
                entry['control']["id"]['controlId'] = find_control_by_id( entry['control']["id"] ).control_id
                entry
              end
            end


            # convert ids for tree
            connection['tree']['disabled'].map! do |entry|
              entry['id']['controlId'] = find_control_by_id( entry["id"] ).control_id
              entry
            end unless connection['tree'].nil? && connection['tree']['disabled'].nil?

          rescue =>e
            #  delete this after create fix column ids
            #  rescue column ids
            Rails.logger.info "!"*50
            Rails.logger.info e.message
            Rails.logger.info "="*20
            Rails.logger.info connection['tree']['disabled'].to_yaml
            Rails.logger.info "_"*50
          end

          connection
       end unless @metadata['connections'].nil?


      end
    end

    class Control
      attr_reader :metadata, :internal_id
      attr_accessor :control_id

      def initialize(metadata)
        @metadata = metadata
        #TODO: Refactor this structure
        @internal_id = @metadata['id']['internalId'] if @metadata['id']
        @control_id = @metadata['id']['controlId']
#        @meta_id = @metadata['id']
      end

      def [](key)
        @metadata[key.to_s]
      end

      def to_hash
        @metadata['controlId'] = @control_id unless @control_id.blank?
        #Backward compatibility. Should be removed after FD client-side refatoring.
#        @metadata['id'] = {}
        @metadata['id']['controlId'] = @control_id unless @control_id.blank?
        @metadata
      end

      def control_id
        @control_id.to_i
      end

      def to_json
        self.to_hash.to_json
      end

    end


    class Column < Control
      attr_reader :controls, :columns

      def initialize(metadata)
        super(metadata)
        @controls = []
        @columns = []
        #Get all column controls and replace them on FromFieldMetadata
        @metadata['columns'].each do |column|
          @columns.push(
             column.map do |control|
                #Create FromFieldMetadata object
                ctrl = Field.new(control['control'])
                @controls.push(ctrl)
                ctrl
             end
          )
        end
      end

      def to_hash
        super
        @metadata['columns'] = @columns.map {|col| col.map(&:to_hash)}
        {'group' => @metadata.to_hash}
      end
    end

    class Field < Control
      def new?
        @control_id.blank?
      end

      def to_hash
        {'control' => super.to_hash}
      end
    end


  end
end
