Factory.define :form_field_value do |ffv|
  ffv.form_field {|ff| ff.association(:form_field)}
  ffv.value "45a"
  ffv.override_reason "Because it is"
  ffv.form_instance {|ff| ff.association(:form_instance)}
end
