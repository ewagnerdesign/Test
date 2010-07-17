require 'spec_helper'

describe Study do
  it "should create a new instance given valid attributes" do
    Factory.create(:study).should be_valid
  end

  #title
  it { should have_db_column(:title).of_type(:string).with_options(:limit => 255, :null => false )}
#  it { should have_db_column(:title).of_type(:string).with_options(:limit => 255, :null => true )}
  it { should validate_presence_of(:title)}
  it { should ensure_length_of(:title).is_at_most(255)}
#  it { should_not ensure_length_of(:title).is_at_most(255)}

  #protocol number
  it { should have_db_column(:protocol_number).of_type(:string).with_options(:limit => 255, :null => false )}
#  it { should have_db_index(:protocol_number).unique(true) }
  it { should validate_presence_of(:protocol_number)}
#  it { should validate_uniqueness_of(:protocol_number)}
  it { should ensure_length_of(:protocol_number).is_at_most(255)}

  #name
  it { should have_db_column(:name).of_type(:string).with_options(:limit => 45, :null => false )}
  it { should have_db_index(:name).unique(true) }
  it { should validate_presence_of(:name)}
  it { should validate_uniqueness_of(:name)}
  it { should ensure_length_of(:name).is_at_most(45)}

  #drug_name
  it { should have_db_column(:drug_name).of_type(:string).with_options(:limit => 255, :null => false )}
  it { should validate_presence_of(:drug_name)}
  it { should ensure_length_of(:drug_name).is_at_most(255)}

  #fpfv
  it { should have_db_column(:fpfv).of_type(:date) }
  it { should validate_presence_of(:fpfv)}

  #lplv
  it { should have_db_column(:lplv).of_type(:date) }
  it { should validate_presence_of(:lplv)}

  #expected_db_lock
  it { should have_db_column(:expected_db_lock).of_type(:date) }
  it { should validate_presence_of(:expected_db_lock)}

  #expected_sites_number
  it { should have_db_column(:expected_sites_number).of_type(:integer) }
  it { should_not validate_presence_of(:expected_sites_number)}
  it { should validate_numericality_of(:expected_sites_number)}

  #active
  it { should have_db_column(:active).of_type(:boolean).with_options(:null => false, :default => true )}

  #therapeutic area
  it { should have_db_column(:therapeutic_area_id).of_type(:integer).with_options(:null => false )}
  it { should validate_presence_of(:therapeutic_area_id)}
  it { should belong_to(:therapeutic_area) }

  #default_study_arm
  it { should have_db_column(:default_study_arm_id).of_type(:integer).with_options(:null => true )}
  it { should_not validate_presence_of(:default_study_arm_id)}
  it { should belong_to(:default_study_arm) }

  #study_users / contacts
  it { should have_many(:study_users) }
  it { should have_many(:contacts) }

  #study_sites / sites
  it { should have_many(:study_sites) }
  it { should have_many(:sites) }

  #study_site_users
  it { should have_many(:study_site_users) }

  #visits
  it { should have_many(:visits) }

  #study_arms
  it { should have_many(:study_arms) }

  #subjects
  it { should have_many(:subjects) }

  #cumulative forms
  it { should have_many(:forms) }

  describe ".create" do
    subject { Factory.create(:study) }

    it { should be_valid }
    its(:errors) { should be_empty }
    it { subject.default_study_arm.should_not be_nil }
  end

  describe ".inactive" do
    subject { Factory.create(:study_inactive) }

    it { should be_valid }
    its(:errors) { should be_empty }
  end

  describe ".removable" do
    subject { Factory.create(:study) }

    it { should_not be_removable } #because of autocreated Default Study Arm

    it "should not be removable if visit attached" do
      subject.visits += [Factory.create(:visit_absolute)]
      subject.should_not be_removable
    end

    it "should not be removable if subject attached" do
      subject.subjects += [Factory.create(:subject)]
      subject.should_not be_removable
    end

    it "should not be removable if study_arm attached" do
      subject.study_arms += [Factory.create(:study_arm)]
      subject.should_not be_removable
    end

    it "should not be removable if monitor_view attached" do
      subject.monitor_views += [Factory.create(:monitor_view)]
      subject.should_not be_removable
    end

    it "should not be removable if study_user attached" do
      subject.contacts += [Factory.create(:user)]
      subject.should_not be_removable
    end

    it "should not be removable if site_user attached" do
      subject.site_users += [Factory.create(:site_user)]
      subject.should_not be_removable
    end

    it "should not be removable if site attached" do
      subject.sites += [Factory.create(:site)]
      subject.should_not be_removable
    end
  end
end
