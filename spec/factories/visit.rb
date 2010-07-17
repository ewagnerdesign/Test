Factory.sequence :visit_number do |n|
  "#{n}"
end

Factory.sequence :visit_name do |n|
  "visit_#{n}"
end

Factory.define :visit do |v|
  v.name { Factory.next(:visit_name) }
  v.number { Factory.next(:visit_number) }
  v.status "Status 2"
  v.study {|a| a.association(:study)}
  v.start_date Time.local(2010, 1, 1)
end

Factory.define :visit_absolute, :parent => :visit do |v|
  v.start_date Time.local(2010, 1, 1)
end

Factory.define :visit_relative, :parent => :visit do |v|
  v.prev_visit_start_offset_day 10
  v.prev_visit_end_offset_day 12
  v.prev_visit {|v| v.association(:visit_absolute)}
end

