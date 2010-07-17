require 'active_record/fixtures'
require 'rubygems'
require 'faker'
require 'pp'
require File.join( RAILS_ROOT, 'vendor/plugins/seed-fu/lib/seed-fu/writer' )


namespace :trovare do
  namespace :data do
    desc 'Clear up existing data'
    task :clear => :environment do
      Subject.destroy_all
      Visit.destroy_all
      Site.destroy_all
      Study.destroy_all
      TherapeuticArea.destroy_all
    end
  end

  desc 'Default CTMS data'

  task :create_default_data => :environment do
    puts "create default data"+"--"*8
    roles = {}
    #Adding users
    users = site_users = []
    studies = []
    #Add study/site users
    10.times { users << create_user(:site_user => false)}
    #Add site/site-study user
    6.times {site_users << create_user(:site_user => true) }

    #Create Roles
    puts "*"*8 + "Creating Roles" + "*"*8

    roles[:system] = Role.create!({
      :name => 'Superduperadmin',
      :description => 'Superadmin Role for superadministrators',
      :category => Role::SYSTEM_LEVEL
    })

    roles[:study] = Role.create!({
      :name => 'Study Admin',
      :description => 'Study admin Role',
      :category => Role::STUDY_LEVEL
    })

    roles[:study] = Role.create!({
      :name => 'Site User',
      :description => 'Site User Role',
      :category => Role::SITE_LEVEL
    })

    roles[:study] = Role.create!({
      :name => 'Study Site User',
      :description => 'Study-Site combination role',
      :category => Role::SITE_STUDY_LEVEL
    })

    a = TherapeuticArea.seed(:name) { |s|
      s.name = 'gastrointestinal tract'
    }

    tarea1 = TherapeuticArea.seed(:name) { |t|
      t.name = 'Histamine2 antagonists'
    }

    # Studies
    study1 = Study.seed(:name) { |s|
      s.title = 'Nexium - Peptic ulcer research'
      s.protocol_number = 1
      s.name = 'Nexium'
      s.drug_name = 'Nexium'
      s.active = true
      s.therapeutic_area = a
      s.fpfv = Date.civil(2010, 6, 17)
      s.lplv = Date.civil(2010, 8, 17)
      s.expected_db_lock = Date.civil(2010, 9, 17)
    }

    study_amoxicillin = Study.seed(:name) { |s|
      s.title = 'Amoxicillin - Peptic ulcer research'
      s.protocol_number = 2
      s.name = 'Amoxicillin'
      s.drug_name = 'Amoxicillin'
      s.active = true
      s.therapeutic_area = a
      s.fpfv = Date.civil(2010, 7, 10)
      s.lplv = Date.civil(2010, 9, 10)
      s.expected_db_lock = Date.civil(2010, 10, 12)
    }

    study2 = Study.seed(:name) { |s|
      s.title = 'Ranitidine Hydrochloride'
      s.protocol_number = 3
      s.name = 'Zantac'
      s.drug_name = 'Zantac'
      s.active = true
      s.therapeutic_area = tarea1
      s.fpfv = Date.today + 1.week
      s.lplv = Date.today + 2.week
      s.expected_db_lock = Date.today + 1.month
    }
    studies.concat([study1, study2, study_amoxicillin])
    #Sites
    site_fawcett = Site.seed(:name) { |s|
      s.name = 'Fawcett Memorial Hospital'
      s.number = 1
      s.investigator = 'Bob Geldof'
      s.active = true
      s.address_1 = '21298 Olean Boulevard'
      s.city = 'Port Charlotte'
      s.state_cd = 'FL'
      s.zip = '33952'
    }

    site1 = Site.seed(:name) { |s|
      s.name = 'Virginia Mason Kirkland'
      s.number = 2
      s.investigator = 'Jenny Park'
      s.active = true
      s.address_1 = '11800 N.E. 128th St. '
      s.address_2= 'Suite 300, Evergreen Plaza Building'
      s.city = 'Kiland'
      s.state_cd = 'WA'
      s.zip = '98034'
    }

    site2 = Site.seed(:name) { |s|
      s.name = 'St. David\'s North Austin Medical Center'
      s.number = 3
      s.investigator = 'Steve Berkowitz'
      s.active = true
      s.address_1 = '12221 N. Mopac Expwy'
      s.city = 'Austin'
      s.state_cd = 'TX'
      s.zip = '78758'
    }
    sites = []
    sites.concat([site_fawcett, site1, site2])

    #Adding sites to studies
    study2.sites << [site1, site2]
    study1.sites << [site_fawcett, site1]
    study_amoxicillin.sites << [site2]
    study2.save!
    study1.save!
    study_amoxicillin.save!

    #Visits
    v1 = Visit.seed(:name) { |s|
      s.name = 'Initial'
      s.number = 1
      s.start_date = study_amoxicillin.fpfv + 1
      s.end_date = study_amoxicillin.fpfv + 2
      s.study = study_amoxicillin
    }

    v2 = Visit.seed(:name) { |s|
      s.name = 'Diagnosis'
      s.number = 2
      s.prev_visit = v1
      s.prev_visit_start_offset_day = 5
      s.prev_visit_end_offset_day = 7
      s.study = study_amoxicillin
    }

    v3 = Visit.seed(:name) { |s|
      s.name = 'Cure'
      s.number = 3
      s.prev_visit = v2
      s.prev_visit_start_offset_day = 5
      s.prev_visit_end_offset_day = 7
      s.study = study_amoxicillin
    }

    study_amoxicillin.default_study_arm.visits += [v1, v2, v3]

    study_amoxicillin.sites += [site_fawcett]
    study_amoxicillin.save!
    #TODO: Add more visits

    #Subjects
    s1 = Subject.seed(:number) { |s|
      s.study = study_amoxicillin
      s.study_arm = study_amoxicillin.default_study_arm
      s.number = 1122334455
      s.randomization_number = 234565476
      s.gender = "M"
      s.dob = Date.civil(1970, 1, 1)
      s.inactive = false
      s.site = site_fawcett
      s.consent_datetime = study_amoxicillin.fpfv + 5
    }

    s2 = Subject.seed(:number) { |s|
      s.study = study_amoxicillin
      s.study_arm = study_amoxicillin.default_study_arm
      s.number = 23334433
      s.randomization_number = 234443222
      s.gender = "F"
      s.dob = Date.civil(1960, 2, 3)
      s.inactive = false
      s.site = site_fawcett
      s.consent_datetime = study_amoxicillin.fpfv + 7
    }

    #Assigning users to a studies/sites etc
    #Create superadmin without any access to the site
    RoleUser.create!({:user => users.pop, :role => roles[:system]})
    #Add users to the study
    12.times do
      begin
        #TODO: Assign user to concrete set of sites
        StudyUser.create!({:user => users.random_element, :study => studies.random_element })
      rescue
        retry
      end
    end
    #Spread users among the sites
    site_assigns = []
    6.times do
      sa = sites.random_element
      su = site_users.pop
      site_assigns[sa.id] = [] unless site_assigns[sa.id]
      site_assigns[sa.id].push(SiteUser.create!({:site => sa, :user=> su}))
    end

    #Set users as a site-study users
    studies.each do |st|
      st.sites.each do |st_site|
        sdata = site_assigns[st_site.id]
        sdata.each do |ssu|
          StudySiteUser.create({:site_user => ssu, :study => st})
        end if sdata
      end
    end
  end

  def create_user(options ={})
    User.create!({
      :login => Faker::Name.first_name.titleize, #Faker::Name.name,
      :email => Faker::Internet.email,
      :password => 'user_123456',
      :password_confirmation => 'user_123456',
      :active => true,
      :city => Faker::Address.city,
      :address_1 => Faker::Address.street_address,
      :address_2 => Faker::Address.secondary_address,
      :zip => Faker.numerify('#####'), #Faker::Address.zip_code,
      :first_name => Faker::Name.first_name,
      :last_name => Faker::Name.last_name,
      :fax => Faker.numerify('#####-#####'), #Faker::PhoneNumber.phone_number,
      :phone => Faker.numerify('#####-#####'), #Faker::PhoneNumber.phone_number,
      :ext => '1',
      :title => %w{PsyD ClinPsyD LicPs BDS BDent PharmD Od B.Optom BSc BSPT MSPT MPt DOM DP PodB ND Aud}.rand,
      :state_cd => Faker::Address.us_state_abbr,
      :time_zone => 'Central Time (US & Canada)'
    }.update(options))
  end
end
