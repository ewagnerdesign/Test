require 'active_record/fixtures'
require 'rubygems'
require File.join( RAILS_ROOT, 'vendor/plugins/seed-fu/lib/seed-fu/writer' )


namespace :trovare do
  desc 'Rebuild Trovare Instance For Dev purposes'
  task :rebuild => :environment do
    puts 'Rebuilding system'
    Rake::Task['trovare:load_data'].invoke
    Rake::Task['trovare:create_default_data'].invoke
    Rake::Task['trovare:disable_security_policies'].invoke
  end

  desc 'Load CTMS data'
#  task :load_data => [:environment, db:drop, db:create, db:migrate, db:seed_fu] do
#    Rake::Task['db:seed_fu'].invoke()
#  end

  task :load_data => :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    #Rake::Task['db:fixtures:load'].invoke
    Rake::Task['db:seed_fu'].invoke
    Rake::Task['trovare:create_default_users'].invoke
    Rake::Task['trovare:set_default_policies'].invoke
  end

  task :create_default_users => :environment do
    puts "create default users"+"--"*8
    User.create! \
              :login => 'admin',
              :email => 'admin@somezzz.com',

#              :password => 'admin_1234',
#              :password_confirmation => 'admin_1234',
              :crypted_password => "ef01e3d396ff985b625e5b8345067e8f9138e04db6bbd892aae34bc650e1c714d5b8d31dc41a41669436ac5f5e9450dc74f062c91ca23ffff80951cf2518becb",
              :password_salt => "JjctJnsWFkJBkgkt8GJC",
              :persistence_token => "5dac39faf5f00c9beeb66f48a35f161322cfa915f3e2aeef5f0c32f16df1e6a6ec69e580a37a3e3808c4e8b6596cc2de4783af05ab3f445c8acc951a549a964c",
              :perishable_token => "sW_RBAvTBWLa8XhvXI5C",

              :active => true,
              :city => 'Chicago',
              :address_1 => '200 S. Wacker Drive',
              :address_2 => '15th Floor',
              :zip => '60606',
              :first_name => 'Ben',
              :last_name => 'Johnson',
              :fax => '3122764299',
              :title => 'Dr.',
              :phone => '3122047269',
              :ext => '1',
              :state_cd => 'IL',
              :time_zone => 'Central Time (US & Canada)'

    User.create! \
              :login => 'monitor',
              :email => 'monitor@somezzz.com',

#              :password => 'monitor_1234',
#              :password_confirmation => 'monitor_1234',
              :crypted_password => "62759eb1edc8deb8b56ceb4813968d1d84db34c7954916b399ee63dcf2f6740461c2a5bccaba34384d7f3d0b3ff9d9d30a83a78db86b002ac058a00db911ca04",
              :password_salt => "GU3qT4TsRipFoTOKKgt4",
              :persistence_token => "72230cabaac2df8566dc1230310677605ff8eafd663e52b3b113a36b5eb3dbf3fd8369dc96453f412528332c1fb99e5f9e534308c7de1b34a16e5ef619b54896",
              :perishable_token => "nKNExkrIpdPYb6vx4co3",

              :active => true,
              :city => 'Chicago',
              :address_1 => '200 S. Wacker Drive',
              :address_2 => '15th Floor',
              :zip => '60606',
              :first_name => 'Bill',
              :last_name => 'Robertson',
              :fax => '3122764299',
              :title => 'Dr.',
              :phone => '3122047269',
              :ext => '1',
              :state_cd => 'IL',
              :time_zone => 'Central Time (US & Canada)'

    User.create! \
              :login => 'investigator',
              :email => 'investigator@somezzz.com',

#              :password => 'investigator_1234',
#              :password_confirmation => 'investigator_1234',
              :crypted_password => "f36a9ee8fcafb05b0df5289309869d2e72b6aea36a65d93b5351974330b1a40f99e91235d7424af01de3e2c5b2e3dd1ecee4bead3b64a408a1d378a0045ad92d",
              :password_salt => "G3x9iOPTi3hv96KflCzs",
              :persistence_token => "7cd93a988fa42c9c3ccbf94150bc8d8fe956263fe56c90bba0f58eecb3eed5baeb8a77a112d286e131bea264773886a6cfe8801c53b988a943cb8709b2591d3f",
              :perishable_token => "IlKTt934T1nCYGRC_HIy",

              :active => true,
              :city => 'Chicago',
              :address_1 => '200 S. Wacker Drive',
              :address_2 => '15th Floor',
              :zip => '60606',
              :first_name => 'John',
              :last_name => 'Smith',
              :fax => '3122764299',
              :title => 'Dr.',
              :phone => '3122047269',
              :ext => '1',
              :state_cd => 'IL',
              :time_zone => 'Central Time (US & Canada)'
  end

  task :set_default_policies => :environment do
    puts "set default policies"+"--"*8
    Settings.password_expiration = 30
    Settings.password_history = 5
    Settings.minimum_password_length = 10
    Settings.password_complexity = 1
    Settings.maximum_invalid_login_attempts = 3
    Settings.lockout_period = 0
    Settings.enable_password_reset = false
  end

  desc "Update existing verion"
  task :update => :environment do
    puts "--"*8+"Upating stage version at #{DateTime.now.to_s}"+"--"*8
    system 'svn up'
    Rake::Task['gems:install'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['restart'].invoke
    puts "..Update complete..\n\n"
  end
end
