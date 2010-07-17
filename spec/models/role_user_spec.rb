require 'spec_helper'

describe RoleUser do
  #role
  it { should have_db_column(:role_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:role_id)}
  it { should belong_to(:role) }
  
  #user
  it { should have_db_column(:user_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:user_id)}
  it { should belong_to(:user) }

  it { should have_db_index([:role_id, :user_id]).unique(true) }
end
