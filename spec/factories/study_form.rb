Factory.define :study_form do |s|
  s.study     {|a| a.association(:study)}
  s.form {|a| a.association(:form)}
end
