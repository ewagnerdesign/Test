ActionMailer::Base.default_charset = "utf-8"
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.smtp_settings = {
    :address => "srv-46",
    :port => 25,
    :tls => true,
    :domain => "sphereconsulting.com",
    :authentication => :login,
#    :authentication => :plain,
    :user_name => "redmineSender",
    :password => "1QAzxsW2"

}
