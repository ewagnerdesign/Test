class Emailer < ActionMailer::Base

  def create_user(user)
    subject "Account activation"
    from "redmine@sphereconsultinginc.com"
    body :user=>user
    content_type "text/html"
    recipients user.email
    cc "akovalchuk@sphere-inc.com.ua"
    sent_on Time.now.in_time_zone(user.time_zone)
  end

end
