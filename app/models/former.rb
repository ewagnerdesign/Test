class Former
  attr_reader :form, :instance, :controls, :tree, :connections

  #Constructor
  #Receives FormInstance object and get all required information

  #Constructor
  #Receives FormInstance object and get all required information
  def initialize(instance)
    @form = instance.form_version.form
    @instance = instance
    @is_new = @instance.id.nil?
    @controls = []
    form_metadata = FD::Metadata::Form.new(instance.form_version.metadata)
    @tree, @controls = build_tree(form_metadata)
    @connections = build_connections(form_metadata)
  end

  #Set form field value for each control
  def create(params)
    params.each_pair do |key, value|
      if key.to_s =~ /control_(\d+)/
        self[$1].value = value unless self[$1].nil?
      end
    end
    save
  end

  #Update form field value for each control
  def update(params)
    params.each_pair do |key, value|
      if key.to_s =~ /control_(\d+)/
        self[$1].value = value unless self[$1].nil?
      end
    end
    save
  end

  #Save form
  def save
    @is_new = false
    @controls.map(&:save)
    @instance.save
  end

  #Access form control by id
  def [](param)
    @controls.select {|control| control.id == param.to_i }.first
  end

  def new?
    @is_new
  end

  protected

  def build_connections(form_metadata)
      form_metadata.connections
  end

  #Build controls tree
  def build_tree(form_metadata)
    tree = form_metadata.metatree.inject([]) do |result, control|

      if control.kind_of? FD::Metadata::Column
        result << FormerGroup.new(self, control)
      end

      begin
        result << FormerControl.new(control, self)
      end if control.kind_of? FD::Metadata::Field
      result
    end

    controls = tree.collect{ |c| c.kind_of?(FormerGroup)? c.columns: c}

    [tree, controls.flatten]
  end
end

#  TODO: refactoring this class
class FormerGroup
  attr_reader :columns, :control, :id

  def initialize(form, control)
    @control = control

    @columns = @control.columns.map do |col|
       col.map do |el|
         FormerControl.new(el, form)
       end
    end
    @id = @control.control_id
  end

end

class FormerControl
  attr_reader :metadata, :options, :value, :type, :id, :form, :field_value, :label, :description
  def initialize(metadata, form)
    @changed = false
    #TODO: Do we really need this
    @metadata = metadata

    @options = @metadata['options'].symbolize_keys!
    @type = @metadata['type'].to_sym
    @form = form
    @id = @metadata.control_id

    @field_value = nil
    unless [:section, :column].include?(@type)
      #Get or create form_field_value record
      @field_value = @form.instance.form_field_values.select {|rec| rec.form_field_id == @id}.first ||
                      @form.instance.form_field_values.build(:form_field_id => @id)

      @value = @field_value.value
      if [:checkbox, :dscheckbox, :dsinput].include?(@type)
        unless value.nil?
          @value = @value.split('{|}')
        else
          @value = []
        end
      end
    end

    @label = @options[:label]
    @description = RedCloth.new(@options[:description]).to_html || ""
    #Add please select option
    self[:options].unshift(['-Please Select-', -1]) if [:dropdown].include?(@type) && self[:emptyElement] == 'true'
    self[:options].update( -1 => '-Please Select-') if [:dsdropdown].include?(@type) && self[:emptyElement] == 'true'
  end

  def save
    #TODO: Validation will be here
    unless [:section, :column].include?(@type)
      if changed?
        @field_value.value = prepare_value
      else
        #We assume that if multicontrols is not updated they are empty
        @field_value.value = "" if [:checkbox, :dscheckbox, :radiobox, :dsradiobox].include?(@type)
      end
    end
  end

  def value=(param)
    @value = param
    @changed = true
  end

  def changed?
    @changed
  end

  def [](param)
    @options[param]
  end

  protected
  def prepare_value
    ([:checkbox, :dscheckbox, :dsinput].include?(@type) ? @value.join('{|}') : @value ) unless @value.nil?
  end
end
