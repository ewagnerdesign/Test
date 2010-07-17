Factory.define :study_site_form_version do |s|
  s.study_site  {|a| a.association(:study_site)}
  s.form_version   {|a| a.association(:form_version)}
end
