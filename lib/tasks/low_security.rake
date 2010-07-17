require 'rubygems'

namespace :trovare do
  desc 'Set low-security settings'

  task :disable_security_policies => :environment do
    puts "set low-security (development) policies"+"--"*8

    Settings.password_expiration = 0
    Settings.password_history = 0
    Settings.minimum_password_length = 1
    Settings.password_complexity = 0
    Settings.maximum_invalid_login_attempts = 0
    Settings.lockout_period = 15
    Settings.enable_password_reset = true
  end
end
