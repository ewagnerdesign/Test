Factory.define :form_field do |ff|
  ff.form_version {|a| a.association(:form_version)}
  ff.label "label"
  ff.description "description"
end
