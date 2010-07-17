Factory.sequence :monitor_view_name do |n|
  "Monitor view #{n}"
end

Factory.define :monitor_view  do |m|
  m.name { Factory.next(:monitor_view_name) }
  m.study { |a| a.association(:study)}
  m.form { |a| a.association(:form)}
end
