Factory.sequence :study_name do |n|
  "Study_#{n}"
end

Factory.define :study do |s|
  s.name { Factory.next(:study_name) }
  s.title "Study title"
  s.protocol_number "c251"
  s.drug_name "drug_name"
  s.therapeutic_area {|ta| ta.association(:therapeutic_area) }
  s.fpfv Date.new(2010, 02, 10)
  s.lplv Date.new(2010, 02, 12)
  s.expected_db_lock Date.new(2010, 02, 16)
end

Factory.define :study_inactive, :parent => :study  do |s|
  s.active false
end
