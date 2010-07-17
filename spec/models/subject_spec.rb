require 'spec_helper'

describe Subject do

  it "should create a new instance given valid attributes" do
    Factory.create(:subject).should be_valid
  end

  it "should create a new instance with male gender attribute" do
    Factory.create(:male_subject).should be_valid
  end

  it "should create a new instance with female gender attribute" do
    Factory.create(:female_subject).should be_valid
  end

  it "should not delete a subject with crf assigned to her" do
    subj = Factory.create(:female_subject)
    Factory.create(:form_instance, :subject => subj)
    subj.destroy.should be_false
  end

  #study
  it { should have_db_column(:study_id).of_type(:integer).with_options(:null => false )}
  it { should validate_presence_of(:study)}
  it { should belong_to(:study) }

  #site
  it { should have_db_column(:site_id).of_type(:integer).with_options(:null => false )}
  it { should validate_presence_of(:site)}
  it { should belong_to(:site) }

  #study_arm
  it { should have_db_column(:study_arm_id).of_type(:integer).with_options(:null => false )}
  it { should validate_presence_of(:study_arm)}
  it { should belong_to(:study_arm) }

  #number
  it { should have_db_column(:number).of_type(:integer).with_options(:null => false )}
  it { should validate_presence_of(:number) }
  it { should have_db_index([:study_id, :number]).unique(true) }
  it { should validate_numericality_of(:number) }

  #randomization_number
  it { should have_db_column(:randomization_number).of_type(:integer).with_options(:null => true )}
  it { should_not validate_presence_of(:randomization_number) }
  it { should validate_numericality_of(:randomization_number) }

  #randomization_number
  it { should have_db_column(:randomization_number).of_type(:integer).with_options(:null => true )}
  it { should_not validate_presence_of(:randomization_number) }
  it { should validate_numericality_of(:randomization_number) }

  #gender
  #strange behaviour of enum in MySQL - it looks like string with 0 length
  it { should have_db_column(:gender).of_type(:string).with_options(:limit => 0, :null => false )}
  it { should validate_presence_of(:gender) }

  #inactive
  it { should have_db_column(:inactive).of_type(:boolean).with_options(:null => false, :default => false )}

  #dob
  it { should have_db_column(:dob).of_type(:date).with_options(:null => false )}
  it { should validate_presence_of(:dob) }

  #consent_datetime
  it { should have_db_column(:consent_datetime).of_type(:datetime).with_options(:null => false )}
  it { should validate_presence_of(:consent_datetime) }

  #form_instances
  it {should have_many(:form_instances)}

  describe ".removable" do
    subject { Factory.create(:subject) }
    it { should be_removable }

    it "should not be removable if form_instance attached" do
      Factory.create(:form_instance, :subject => subject)
      subject.should_not be_removable
    end
  end

  describe ".site" do
    subject { Factory.create(:subject) }

    it "should be possible to specify other site from specified study" do
      site2 = Factory.create(:site)
      subject.study.sites += [site2]
      subject.site = site2
      subject.should be_valid
    end

    it "should be impossible to specify site not belonging to the study" do
      site2 = Factory.create(:site)
      subject.site = site2
      subject.should_not be_valid
    end
  end
end
