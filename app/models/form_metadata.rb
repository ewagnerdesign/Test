class FormMetadata
  attr_reader :columns, :controls, :metadata

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
        ctrl = FormColumnMetadata.new(control)
        @columns.push(ctrl)
        result.push(ctrl)
      end unless control['group'].nil?
      #Raw control
      begin
        ctrl = FormFieldMetadata.new(control)
        @raw_controls.push(ctrl)
        result.push(ctrl)
      end unless control['control'].nil?
      result
    end

    #Collect all connections
    @metadata['connections'].collect! do |connection|
        FormConnectionMetadata.new(connection)
    end unless @metadata['connections'].nil?

    #General control list
    @controls = []

    #Add controls within columns to the controls list
    @controls = @raw_controls
    @columns.each do |column|
      @controls += column.controls
    end
  end

  #Access to meadata tree
  def metatree
    metadata['controls']
  end

  #Access form metadata in structure directly
  def method_missing(name, *args)
    name = name.to_s
    if name =~ /(.+)=/
      #Setter
      @metadata['form'][$1] = *args.first
    elsif name =~ /(.+)/
      @metadata['form'][$1] unless @metadata['form'][$1].nil?
    end
  end

  #Convert data structure into JSON
  def to_json
    self.to_hash.to_json
  end

  #Covert data structure into hash
  def to_hash
    #Prevent inplace object chane to keep its state
    tohash = @metadata.clone
    #Call appropriate to_hash method for all available controls
    tohash['controls'].map!(&:to_hash)
    #Call appropriate to_hash method for all available connections
    tohash['connections'].map!(&:to_hash) unless tohash['connections'].nil?
    tohash
  end

  def clear
	  FormControlId.clear
  end
end

# class for rebinding javascript elements ids to server side and inversely
class FormControlId
# TODO: refactoring this class
  private_class_method :new
  attr_reader :control_id

  def initialize(data)
    if data.instance_of?(Hash)
      unless data.key?('controlId') && data.key?('internalId')
        raise "FormControlId.initialize invalid data"
      end
      @control_id = data['controlId']
      @internal_id = data['internalId']
    else
      @control_id = data
      @internal_id =""
    end


    # generate unique key
    @unique_key = "#{@control_id}-#{@internal_id}"
  end

  def key
    @unique_key
  end

  def control_id=(new_id)
    @control_id = new_id
    @internal_id = ""
  end

  def newControl?
    @control_id==""
  end

  def to_hash
    {
      "controlId" => @control_id,
      "internalId" => @internal_id
     }
  end

  def to_json
    to_hash.to_json
  end

  @@instances = {}

  def self.[](id)
    instance = new(id)
    unless @@instances.key?( instance.key )
      @@instances[instance.key] = instance
    end
    @@instances[instance.key]
  end

  def self.clear
	@@instances = {}
  end

end

# Class representing column group metadata
class FormColumnMetadata
  attr_reader :controls, :columns
  def initialize(data)
    @data = data
    @controls = []
    @columns = []
    #Get all column controls and replace them on FromFieldMetadata
    @data['group']['columns'].each do |column|
      @columns.push(column.map do |control|
        #Create FromFieldMetadata object
        ctrl = FormFieldMetadata.new(control)
        @controls.push(ctrl)
        ctrl
      end)
    end
  end

  #Set group properties
  def method_missing(name, *args)
    name = name.to_s
    if name =~ /(.+)=/
      #Setter
      @data['group'][$1] = *args.first
    elsif name =~ /(.+)/
      @data['group'][$1]
    end
  end

  #Convert column to JSON
  def to_json
    self.to_hash.to_json
  end

  def to_hash
    #Covert all children controls into JSON
    @data['group']['columns'] = @columns.map {|col| col.map(&:to_hash)}
    @data
  end
end

class FormFieldMetadata
  attr_reader :data

  def initialize(data)
    @data = data
    @id =
      if data['control'].key?('id')
         FormControlId[ data['control']['id'] ]
      else
        FormControlId[ data['control']['controlId'] ]
      end
  end

  def [](name)
    @data['control'][name.to_s]
  end

  def method_missing(name, *args)
    name = name.to_s
    if name =~ /(.+)=/
      #Setter
      @data['control'][$1] = *args.first
    elsif name =~ /(.+)/
      @data['control'][$1]
    end
  end

  def new?
    @id.newControl?
  end

  def record_id
     @id.control_id
  end

  def record_id=(new_id)
    @data['control']['controlId'] = new_id
    @id.control_id=new_id
  end

  def to_hash
    @data['control']['id'] = @id.to_hash
    @data
  end

  def to_json
    @data.to_json
  end
end


class FormConnectionMetadata

  def initialize(data)
    @data = data
    prepare_ids
  end


  def to_hash
     tohash = @data.clone
     %w(targets sources).each do |path|
       tohash[path].map do |target|
         target['control']["id"] = target['control']["id"].to_hash
         target
       end
     end
    tohash
  end

  def to_json
    @data.to_json
  end

  private
  def prepare_ids
    %w(targets sources).each do |path|
      @data[path].map do |target|
        target['control']["id"] = FormControlId[ target['control']["id"] ]
        target
      end
    end
  end

end

