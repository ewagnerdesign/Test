require 'spec_helper'

describe Site do
  it "should create a new instance given valid attributes" do
    site = Factory(:site)
    site.should be_valid
    site.errors.should be_empty
  end

  #name
  it { should have_db_column(:name).of_type(:string).with_options(:limit => 45, :null => false )}
  it { should have_db_index(:name).unique(true) }
  it { should validate_presence_of(:name)}
  it { should validate_uniqueness_of(:name)}
  it { should ensure_length_of(:name).is_at_most(45)}

  #number
  it { should have_db_column(:number).of_type(:string).with_options(:limit => 45, :null => true )}
  it { should_not validate_presence_of(:number)}
  it { should ensure_length_of(:number).is_at_most(45)}

  #investigator
  it { should have_db_column(:investigator).of_type(:string).with_options(:limit => 45, :null => true )}
  it { should_not validate_presence_of(:investigator)}
  it { should ensure_length_of(:investigator).is_at_most(45)}

  #active
  it { should have_db_column(:active).of_type(:boolean).with_options(:null => false, :default => true )}
  it { should validate_presence_of(:active)}

  #address_1
  it { should have_db_column(:address_1).of_type(:string).with_options(:limit => 255, :null => false )}
  it { should validate_presence_of(:address_1)}
  it { should ensure_length_of(:address_1).is_at_most(255)}

  #address_2
  it { should have_db_column(:address_2).of_type(:string).with_options(:limit => 255, :null => true )}
  it { should_not validate_presence_of(:address_2)}
  it { should ensure_length_of(:address_2).is_at_most(255)}

  #city
  it { should have_db_column(:city).of_type(:string).with_options(:limit => 45, :null => false )}
  it { should validate_presence_of(:city)}
  it { should ensure_length_of(:city).is_at_most(45)}

  #zip
  it { should have_db_column(:zip).of_type(:string).with_options(:limit => 5, :null => false )}
  it { should validate_presence_of(:zip)}
  it { should ensure_length_of(:zip).is_at_least(5).is_at_most(5)}

  #state_cd
  it { should have_db_column(:state_cd).of_type(:string).with_options(:limit => 2, :null => false )}
  it { should validate_presence_of(:state_cd)}
  it { should ensure_length_of(:state_cd).is_at_least(2).is_at_most(2)}

  #time_zone
  it { should have_db_column(:time_zone).of_type(:string).with_options(:limit => 255, :null => true )}
  it { should_not validate_presence_of(:time_zone)}
  it { should ensure_length_of(:time_zone).is_at_most(255)}

  #phone
  it { should have_db_column(:phone).of_type(:string).with_options(:limit => 10, :null => true )}
  it { should_not validate_presence_of(:phone)}

  #fax
  it { should have_db_column(:fax).of_type(:string).with_options(:limit => 10, :null => true )}
  it { should_not validate_presence_of(:fax)}

  #ext
  it { should have_db_column(:ext).of_type(:string).with_options(:limit => 5, :null => true )}
  it { should_not validate_presence_of(:ext)}

  #study_sites / studies
  it { should have_many(:study_sites) }
  it { should have_many(:studies) }

  #site_study_users / study_users
  it { should have_many(:site_study_users) }
  it { should have_many(:study_users) }

  #site_users / users
  it { should have_many(:site_users) }
  it { should have_many(:contacts) }

  describe ".removable" do
    subject { Factory.create(:site) }

    it { should be_removable }

    it "should not be removable if subject attached" do
      subject.subjects += [Factory.create(:subject)]
      subject.should_not be_removable
    end

    it "should not be removable if study attached" do
      subject.studies += [Factory.create(:study)]
      subject.should_not be_removable
    end

    it "should not be removable if user attached" do
      subject.contacts += [Factory.create(:user)]
      subject.should_not be_removable
    end

    it "should not be removable if study_user attached" do
      subject.study_users += [Factory.create(:study_user)]
      subject.should_not be_removable
    end
  end
end
