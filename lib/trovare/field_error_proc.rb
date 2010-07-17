require "field_error_proc_helper"

ActionView::Base.field_error_proc = Proc.new do |html_element, instance|
  FieldErrorProcHelper.add_css_class_to_element('LV_invalid_field', html_element)
end  
