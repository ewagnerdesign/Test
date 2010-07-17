Factory.define :form_instance do |f|
  f.form_version {|a| a.association(:form_version)}
  f.subject {|a| a.association(:subject)}
  f.visit {|a| a.association(:visit)}
  f.submitted true
end

Factory.define :form_instance_unsubmitted, :parent => :form_instance do |f|
  f.submitted false
end
