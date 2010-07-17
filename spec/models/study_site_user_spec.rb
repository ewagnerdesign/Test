require 'spec_helper'

describe StudySiteUser do
  #study
  it { should have_db_column(:study_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:study_id)}
  it { should belong_to(:study) }
  
  #site_user
  it { should have_db_column(:site_user_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:site_user_id)}
  it { should belong_to(:site_user) }

  it { should have_many(:role_study_site_users) }
  it { should have_many(:roles) }

  it { should have_db_index([:study_id, :site_user_id]).unique(true) }
end
