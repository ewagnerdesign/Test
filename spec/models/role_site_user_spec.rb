require 'spec_helper'

describe RoleSiteUser do
  #role
  it { should have_db_column(:role_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:role_id)}
  it { should belong_to(:role) }
  
  #site_user
  it { should have_db_column(:site_user_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:site_user_id)}
  it { should belong_to(:site_user) }

  it { should have_db_index([:role_id, :site_user_id]).unique(true) }
end
