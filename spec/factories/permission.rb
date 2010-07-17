Factory.sequence :permission_name do |n|
  "Name #{n}".rjust(2, '0')
end

Factory.define :permission do |s|
  s.name { Factory.next(:permission_name) }
  s.description "RubyTest"
  s.category 0
end 