Factory.sequence :study_arm_code do |n|
  "#{n}"
end

Factory.define :study_arm do |s|
  s.code { Factory.next(:study_arm_code) }
  s.study {|a| a.association(:study)}
end
