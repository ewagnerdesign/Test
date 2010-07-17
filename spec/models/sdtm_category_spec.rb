require 'spec_helper'

describe SdtmCategory do
  it "should create a new instance given valid attributes" do
    sdtm_category = Factory(:sdtm_category)
    sdtm_category.should be_valid
    sdtm_category.errors.should be_empty
  end

  #code
  it { should have_db_column(:code).of_type(:string).with_options(:limit => 45, :null => false )}
  it { should have_db_index(:code).unique(true) }
  it { should validate_presence_of(:code)}
  it { should ensure_length_of(:code).is_at_most(45)}
  it { should validate_uniqueness_of(:code)}

  #extensible
  it { should have_db_column(:extensible).of_type(:boolean).with_options(:null => false, :default => false )}
  it { should_not validate_presence_of(:extensible)}

  #name
  it { should have_db_column(:name).of_type(:string).with_options(:limit => 255, :null => false )}
  it { should validate_presence_of(:name)}
  it { should ensure_length_of(:name).is_at_most(255)}

  #submission_value
  it { should have_db_column(:submission_value).of_type(:string).with_options(:limit => 255, :null => false )}
  it { should validate_presence_of(:submission_value)}
  it { should ensure_length_of(:submission_value).is_at_most(255)}

  #cdisc_preferred_term
  it { should have_db_column(:cdisc_preferred_term).of_type(:string).with_options(:limit => 255, :null => false )}
  it { should validate_presence_of(:cdisc_preferred_term)}
  it { should ensure_length_of(:cdisc_preferred_term).is_at_most(255)}

  #synonyms
  it { should have_db_column(:synonyms).of_type(:string).with_options(:limit => 255, :null => false )}
  it { should validate_presence_of(:synonyms)}
  it { should ensure_length_of(:synonyms).is_at_most(255)}

  #nci_preferred_term
  it { should have_db_column(:nci_preferred_term).of_type(:string).with_options(:limit => 255, :null => false )}
  it { should validate_presence_of(:nci_preferred_term)}
  it { should ensure_length_of(:nci_preferred_term).is_at_most(255)}

  #definition
  it { should have_db_column(:definition).of_type(:text).with_options(:null => true )}
  it { should_not validate_presence_of(:definition)}

  #read_only
  it { should have_db_column(:read_only).of_type(:boolean).with_options(:null => false, :default => true )}
  it { should_not validate_presence_of(:read_only)}
  
  describe ".removable for predefined sdtm" do
    subject { Factory.create(:sdtm_category_read_only) }
    it { should_not be_removable } 
  end

  describe ".removable for manually entered sdtm" do
    subject { Factory.create(:sdtm_category, :read_only => false) }
    it { should be_removable }

    it "should not be removable if form_field attached" do
      Factory.create(:form_field, :sdtm_category => subject)
      subject.should_not be_removable
    end
    
    it "should not be removable if cdash_question attached" do
      Factory.create(:cdash_question, :sdtm_category => subject)
      subject.should_not be_removable
    end

    it "should not be removable if sdtm_answer attached" do
      Factory.create(:sdtm_answer, :sdtm_category => subject)
      subject.should_not be_removable
    end
  end
end
