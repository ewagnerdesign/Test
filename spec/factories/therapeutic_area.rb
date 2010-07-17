Factory.sequence :therapeutic_area_name do |n|
  "th_area_#{n}"
end

Factory.define :therapeutic_area do |ta|
  ta.name { Factory.next(:therapeutic_area_name) }
end
