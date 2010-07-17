require 'spec_helper'

describe SiteUser do
  #site
  it { should have_db_column(:site_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:site_id)}
  it { should belong_to(:site) }
  
  #user
  it { should have_db_column(:user_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:user_id)}
  it { should belong_to(:user) }

  #roles
  it { should have_many(:role_site_users) }
  it { should have_many(:roles) }

  #studies
  it { should have_many(:study_site_users) }
  it { should have_many(:studies) }

  it { should have_db_index([:site_id, :user_id]).unique(true) }
end
