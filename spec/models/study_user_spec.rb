require 'spec_helper'

describe StudyUser do
  #study
  it { should have_db_column(:study_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:study_id)}
  it { should belong_to(:study) }
  
  #user
  it { should have_db_column(:user_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:user_id)}
  it { should belong_to(:user) }

  # role_study_users / roles
  it { should have_many(:role_study_users) }
  it { should have_many(:roles) }

  # site_study_users / sites
  it { should have_many(:site_study_users) }
  it { should have_many(:sites) }

  it { should have_db_index([:study_id, :user_id]).unique(true) }
  
end
