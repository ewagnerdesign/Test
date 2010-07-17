require 'spec_helper'

describe StudySite do
  #study
  it { should have_db_column(:study_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:study_id)}
  it { should belong_to(:study) }
  
  #site
  it { should have_db_column(:site_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:site_id)}
  it { should belong_to(:study) }

  it { should have_db_index([:study_id, :site_id]).unique(true) }
  
end
