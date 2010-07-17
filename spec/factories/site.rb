Factory.sequence :site_name do |n|
  "Site_#{n}"
end

Factory.define :site  do |s|
  s.name { Factory.next(:site_name) }
  s.number 'number'
  s.active 1
  s.address_1 "address_1"
  s.address_2 "address_2"
  s.city "city"
  s.state_cd 'IL'
  s.phone '1234567890'
  s.ext '21345'
  s.fax '9087654321'
  s.zip '12345'
  s.time_zone 'Samoa'
end

