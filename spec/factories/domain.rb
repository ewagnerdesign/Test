Factory.sequence :domain_code do |n|
  "#{n}".rjust(2, '0')
end

Factory.sequence :domain_name do |n|
  "Name #{n}".rjust(2, '0')
end

Factory.define :domain do |s|
  s.code { Factory.next(:domain_code) }
  s.name { Factory.next(:domain_name) }
  s.domain_class "RubyTest"
end 