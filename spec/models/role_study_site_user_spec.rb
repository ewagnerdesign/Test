require 'spec_helper'

describe RoleStudySiteUser do
  #role
  it { should have_db_column(:role_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:role_id)}
  it { should belong_to(:role) }
  
  #study_site_user
  it { should have_db_column(:study_site_user_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:study_site_user_id)}
  it { should belong_to(:study_site_user) }

  it { should have_db_index([:role_id, :study_site_user_id]).unique(true) }
end
