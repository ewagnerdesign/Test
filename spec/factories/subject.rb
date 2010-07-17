Factory.define :subject do |s|
  s.association(:study)
  s.association(:site)
  s.after_create { |a| a.study.sites += [a.site] }
  s.after_build { |a| a.study.sites += [a.site] }
  s.study_arm {|a| a.association(:study_arm)}
  s.number 423
  s.randomization_number 56
  s.gender "F"
  s.dob Date.new(1981, 03, 12)
  s.consent_datetime DateTime.now << 87
  s.inactive false
end

Factory.define :female_subject, :parent  => :subject do |s|
  s.gender "F"
end

Factory.define :male_subject, :parent  => :subject do |s|
  s.gender "M"
end

