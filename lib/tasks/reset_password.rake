require 'active_record/fixtures'
require 'rubygems'
require File.join( RAILS_ROOT, 'vendor/plugins/seed-fu/lib/seed-fu/writer' )

namespace :trovare do
  desc 'reset password for user'
  task :reset_password, :needs  => :environment do |t|
    user_name = ENV['user_name']
    puts "user_name=#{user_name}"
    password = user_name + "_1234"
    puts "password=#{password}"
    usr = User.login_eq(user_name).first
    usr.unlock(password)
  end

end
