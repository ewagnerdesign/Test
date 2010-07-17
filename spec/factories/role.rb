Factory.sequence :role_name do |n|
  "Name #{n}".rjust(2, '0')
end

Factory.sequence :description do |n|
  "Description of role #{n}"
end


Factory.define :role do |s|
  s.name { Factory.next(:role_name) }
  s.description { Factory.next(:description) }
  s.category 0
end
