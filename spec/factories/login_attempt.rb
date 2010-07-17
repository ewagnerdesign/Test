Factory.sequence :login_attempt_login do |n|
  "login_#{n}"
end

Factory.define :login_attempt  do |l|
  l.login { Factory.next(:login_attempt_login) }
  l.ip "127.0.0.1"
  l.user_agent "Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.3) Gecko/20100423 Ubuntu/10.04 (lucid) Firefox/3.6.3"
  l.user_id nil
  l.successfull false
end
