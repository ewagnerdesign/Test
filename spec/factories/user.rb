Factory.sequence :login do |n|
  "__trovare_#{n}"
end

Factory.sequence :email do |n|
  "trovare_#{n}@localhost.com"
end

Factory.sequence :name do |n|
  "Trovare ##{n}"
end


Factory.define :employee, :class => User do |employee|
  employee.active false
  employee.first_name "Glenn"
  employee.middle_name "M"
  employee.last_name "Nillsen"
  employee.title "Super Investigator"
  employee.email { Factory.next(:email) }
  employee.address_1 "Address 1"
  employee.address_2 "Address 2"
  employee.city "Chicago"
  employee.state_cd "IL"
  employee.zip "54000"
  employee.phone "3805012345"
  employee.ext "123"
  employee.fax "3805012345"
  employee.web_site "web@domain.com"
  employee.time_zone 'Samoa'
  employee.site_user true
  employee.first_login false
end

Factory.define :user, :parent => :employee do |user|
  user.login { Factory.next(:login) }
  user.active true
end

Factory.define :user_monitor, :parent => :user do |um|
  um.login 'monitor'
  um.password 'monitor123#'
  um.password_confirmation 'monitor123#'
  um.site_user false
end

Factory.define :user_investigator, :parent => :user do |ui|
  ui.login 'investigator'
  ui.password 'investigator123*'
  ui.password_confirmation 'investigator123*'
  ui.site_user false
end
