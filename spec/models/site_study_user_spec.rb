require 'spec_helper'

describe SiteStudyUser do
  #study_user
  it { should have_db_column(:study_user_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:study_user_id)}
  it { should belong_to(:study_user) }
  
  #site
  it { should have_db_column(:site_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:site_id)}
  it { should belong_to(:site) }

  it { should have_db_index([:site_id, :study_user_id]).unique(true) }
end
