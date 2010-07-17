require 'spec_helper'

describe User do
  subject {Factory.build(:employee)}

  #active
  it { should have_db_column(:active).of_type(:boolean).with_options(:null => false, :default => true )}

  #address_1
  it { should have_db_column(:address_1).of_type(:string).with_options(:limit => 255, :null => false )}
  it { should validate_presence_of(:address_1)}
  it { should ensure_length_of(:address_1).is_at_most(255)}

  #address_2
  it { should have_db_column(:address_2).of_type(:string).with_options(:limit => 255, :null => true )}
  it { should_not validate_presence_of(:address_2)}
  it { should ensure_length_of(:address_2).is_at_most(255)}

  #city
  it { should have_db_column(:city).of_type(:string).with_options(:limit => 45, :null => false )}
  it { should validate_presence_of(:city)}
  it { should ensure_length_of(:city).is_at_most(45)}

  #zip
  it { should have_db_column(:zip).of_type(:string).with_options(:limit => 5, :null => false )}
  it { should validate_presence_of(:zip)}
  it { should ensure_length_of(:zip).is_at_least(5).is_at_most(5)}

  #state_cd
  it { should have_db_column(:state_cd).of_type(:string).with_options(:limit => 2, :null => false )}
  it { should validate_presence_of(:state_cd)}
  it { should ensure_length_of(:state_cd).is_at_least(2).is_at_most(2)}

  #check for authlogic
  it { should have_authlogic }

  #login / password are not required for a employee
  it { should_not validate_presence_of(:login)}
  it { should_not validate_presence_of(:password)}
  it { should_not validate_presence_of(:password_confirmation)}

  #login count
  it { should have_db_column(:login_count).of_type(:integer).with_options(:null => false )}
  it { should validate_presence_of(:login_count)}

  #failed login count
  it { should have_db_column(:failed_login_count).of_type(:integer).with_options(:null => false )}
  it { should validate_presence_of(:failed_login_count)}

  #last request at
  it { should have_db_column(:last_request_at).of_type(:datetime).with_options(:null => true )}
  it { should_not validate_presence_of(:last_request_at)}

  #current login at
  it { should have_db_column(:current_login_at).of_type(:datetime).with_options(:null => true )}
  it { should_not validate_presence_of(:current_login_at)}

  #last login at
  it { should have_db_column(:last_login_at).of_type(:datetime).with_options(:null => true )}
  it { should_not validate_presence_of(:last_login_at)}

  #last login ip
  it { should have_db_column(:last_login_ip).of_type(:string).with_options(:limit => 15, :null => true )}
  it { should_not validate_presence_of(:last_login_ip)}

  #current login ip
  it { should have_db_column(:current_login_ip).of_type(:string).with_options(:limit => 15, :null => true )}
  it { should_not validate_presence_of(:current_login_ip)}

  #first_name
  it { should have_db_column(:first_name).of_type(:string).with_options(:limit => 255, :null => false )}
  it { should validate_presence_of(:first_name)}
  it { should ensure_length_of(:first_name).is_at_most(255)}

  #last_name
  it { should have_db_column(:last_name).of_type(:string).with_options(:limit => 255, :null => false )}
  it { should validate_presence_of(:last_name)}
  it { should ensure_length_of(:last_name).is_at_most(255)}

  #middle_name
  it { should have_db_column(:middle_name).of_type(:string).with_options(:limit => 255, :null => true )}
  it { should_not validate_presence_of(:middle_name)}
  it { should ensure_length_of(:middle_name).is_at_most(255)}

  #title
  it { should have_db_column(:title).of_type(:string).with_options(:limit => 255, :null => false )}
  it { should validate_presence_of(:title)}
  it { should ensure_length_of(:title).is_at_most(255)}

  #phone
  it { should have_db_column(:phone).of_type(:string).with_options(:limit => 10, :null => true )}
  it { should_not validate_presence_of(:phone)}

  #fax
  it { should have_db_column(:fax).of_type(:string).with_options(:limit => 10, :null => true )}
  it { should_not validate_presence_of(:fax)}

  #web_site
  it { should have_db_column(:web_site).of_type(:string).with_options(:limit => 255, :null => true )}
  it { should_not validate_presence_of(:web_site)}
  it { should ensure_length_of(:web_site).is_at_most(255)}

  #ext
  it { should have_db_column(:ext).of_type(:string).with_options(:limit => 5, :null => true )}
  it { should_not validate_presence_of(:ext)}

  #time_zone
  it { should have_db_column(:time_zone).of_type(:string).with_options(:limit => 255, :null => false )}
  it { should validate_presence_of(:time_zone)}
  it { should ensure_length_of(:time_zone).is_at_most(255)}


  it { should have_many(:study_users) }
  it { should have_many(:studies) }
  it { should have_many(:site_users) }
  it { should have_many(:sites) }
  it { should have_many(:login_attempts) }

  it { should have_many(:old_passwords) }

  #site_user
  it { should have_db_column(:site_user).of_type(:boolean).with_options(:null => false, :default => true )}

  it { should have_db_column(:login_locked).of_type(:datetime).with_options(:null => true)}

  describe "when activated" do
    subject{ Factory.build(:user) }

    #login / password are required for user
    it { should validate_presence_of(:login)}


    describe "has empty password" do

      before(:each) do
        subject.crypted_password = nil
        subject.password_salt = nil
      end

      it { should be_password_empty }

      it "should be generate new password and call send email" do
        Emailer.should_receive(:deliver_create_user).with(subject)
        subject.save()
        should_not be_password_empty()
      end
    end
  end

  describe "password security policies" do

    describe "check new passord" do
      it {Factory.build(:user, :password => "qwerty12345_", :password_confirmation => "qwerty12345_").should be_valid}
      it {Factory.build(:user, :password => "qwert_0yyyyy", :password_confirmation => "qwert_0yyyyy").should be_valid}
      it {Factory.build(:user, :password => "%00000000s00", :password_confirmation => "%00000000s00").should be_valid}
      it {Factory.build(:user, :password => "%000\\0000s00", :password_confirmation => "%000\\0000s00").should be_valid}

      describe "different password and password_confirmation" do
        it {Factory.build(:user, :password => "qwerty12345_", :password_confirmation => "qqqqqq12345_").should_not be_valid}
        it {Factory.build(:user, :password => "qwerty12345_", :password_confirmation => "").should_not be_valid}
        it {Factory.build(:user, :password => ""            , :password_confirmation => "").should_not be_valid}
        it {Factory.build(:user, :password => ""            , :password_confirmation => "qwerty12345_").should_not be_valid}
      end

      describe "weak password" do
        it {Factory.build(:user, :password => "qwerty123456", :password_confirmation => "qwerty123456").should_not be_valid} # without symbol
        it {Factory.build(:user, :password => "qwertyqqqqqq", :password_confirmation => "qwertyqqqqqq").should_not be_valid} # without number
        it {Factory.build(:user, :password => "111111111111", :password_confirmation => "111111111111").should_not be_valid} # without alpha
        it {Factory.build(:user, :password => "q1_"         , :password_confirmation => "q1_").should_not be_valid} # too small
      end

      describe "old password" do
        it "storing old passwords in old_passwords table" do
          user = Factory.create(:user)
          user.old_passwords.count.should == 0

          user.password = user.password_confirmation = "qwerty123456_"
          user.save!
          user.old_passwords.count.should == 1

          user.password = user.password_confirmation = "_qwerty123456_"
          user.save!
          user.old_passwords.count.should == 2
        end

        it "checking password history" do
          Settings.password_history = 5

          user = Factory.create(:user)
          old_pass = user.password

          # change password
          user.password = user.password_confirmation = "qwerty123456_"
          user.save!

          user.password = user.password_confirmation = old_pass
          user.should_not be_valid
        end
      end
    end

    describe "password expiration" do
      before(:each) do
        Settings.password_expiration = 30
      end

      it "user with fresh password" do
        user = Factory.build(:user, :created_at => Time.new - 10 * 24 * 60 * 60)
        user.should_not be_password_expired
      end

      it "user with expired password" do
        user = Factory.build(:user, :created_at => Time.new - 100 * 24 * 60 * 60)
        user.should be_password_expired
      end

      it "user with recently changed password" do
        user = Factory.build(:user)
        user.password = user.password_confirmation = "qwerty123456_"
        user.save!

        user.should_not be_password_expired
      end

      it "user with expired password" do
        user = Factory.create(:user)
        user.password = user.password_confirmation = "qwerty123456_"
        user.save!

        user.old_passwords[0].created_at = Time.new - 100 * 24 * 60 * 60
        user.old_passwords[0].save!

        user.should be_password_expired
      end

    end

  end
  
end
