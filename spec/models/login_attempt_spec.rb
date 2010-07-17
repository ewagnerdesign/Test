require 'spec_helper'

describe LoginAttempt do
  subject {Factory.build(:login_attempt)}

  #login
  it { should have_db_column(:login).of_type(:string)}

  #created_at
  it { should have_db_column(:created_at).of_type(:datetime) }

  #ip
  it { should have_db_column(:ip).of_type(:string).with_options(:limit => 15, :null => false )}
  it { should validate_presence_of(:ip)}
  it { should ensure_length_of(:ip).is_at_most(15)}

  #user_agent
  it { should have_db_column(:user_agent).of_type(:string).with_options(:limit => 255, :null => false )}
  it { should validate_presence_of(:user_agent)}
  it { should ensure_length_of(:user_agent).is_at_most(255)}

  #successfull
  it { should have_db_column(:successfull).of_type(:boolean).with_options(:null => false )}
  it { should_not validate_presence_of(:successfull)}

  describe "when activated" do
    subject {Factory.build(:login_attempt)}

    #required attributes for login_attempt
    it { should validate_presence_of(:ip)}
    it { should validate_presence_of(:user_agent)}
  end

end
