Factory.define :study_arm_visit do |s|
  s.visit     {|a| a.association(:visit)}
  s.study_arm {|a| a.association(:study_arm)}
end
