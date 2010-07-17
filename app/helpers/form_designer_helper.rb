module FormDesignerHelper
  def text_area_tag_val(name, options = {})
    value = options.delete(:value)
    text_area_tag(name, value, options)
  end

  def control_label(control, text=false)
    return "" unless control[:label_enable].eql? "true"
    label_tag control_id(control), ( text || control[:label] )+ control_required(control)
  end

  def control_required(control)
    if control_required?(control)
      " *"
    else
      ""
    end
  end

  def control_required?(control)
    control.metadata['validators'].detect do |validator|
      %w( select_count required ).include?(validator['type']) && validator['data']['enable']
    end
  end

  def former_control_options(control)
    options = {}
    options.merge!(former_control_identifiers(control)).merge!(former_control_value(control))
  end

  def former_control_identifiers(control, counter=0)
    unless control.id.blank?
      identifiers = {:id =>control_id(control), :name=>"form[base][#{control_id(control)}]"}

      if !counter.zero? && ( !control[:options].nil? && control[:options].first.first.to_i!=counter.to_i )
        identifiers[:id] += "_#{counter}"
      end
      identifiers[:name] += '[]' if [:checkbox, :dscheckbox, :dsinput].include?(control.type)
      identifiers
    else
      {}
    end
  end

  def control_id2(control)
    "#{control_id(control)}_select"
  end

  def control_id(control)
    "control_#{control.id}"
  end

  private
  def former_control_value(control)
    unless control.value.blank?
      result = case control.type
        when :input then {:value => control.value }
        when :textarea then {:value => control.value }
        when :dsinput then {:value => control.value.first}
        else {}
      end
    else
      {}
    end
  end

  def former_control_selected?(control, val)
    if control.form.new?
      #return control[:selected].include?(val) if control[:selected].kind_of? Array
      #control[:selected] == val
      false
    else
      return control.value.include?(val) if control.value.kind_of? Array
      control.value == val
    end
  end

  def former_dropdown_selected(control)
    if control.form.new?
      control[:selected]
    else
      control.value
    end
  end

end
