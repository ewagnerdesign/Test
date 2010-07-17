require 'spec_helper'

describe Domain do
  before(:each) do
    @domain = Factory.create(:domain)
  end

  it "should create a new instance given valid attributes" do
    @domain.should be_valid
  end

  #code
  it { should have_db_column(:code).of_type(:string).with_options(:limit => 2, :null => false )}
  it { should have_db_index(:code).unique(true) }
  it { should validate_presence_of(:code)}
  it { should ensure_length_of(:code).is_at_least(2).is_at_most(2)}
  it { should validate_uniqueness_of(:code)}
  
  #name  
  it { should have_db_column(:name).of_type(:string).with_options(:limit => 255, :null => false )}
  it { should have_db_index(:name).unique(true) }
  it { should validate_presence_of(:name)}
  it { should validate_uniqueness_of(:name)}
  it { should ensure_length_of(:name).is_at_most(255)}

  #domain_class
  it { should have_db_column(:domain_class).of_type(:string).with_options(:limit => 255, :null => false )}
  it { should validate_presence_of(:domain_class)}
  it { should ensure_length_of(:domain_class).is_at_most(255)}

  #description
  it { should have_db_column(:description).of_type(:text) }

  it {should have_many(:cdash_questions) }

  describe ".removable" do
    subject { Factory.create(:domain) }
    it { should be_removable }

    it "should not be removable if form attached" do
      Factory.create(:form, :domain => subject)
      subject.should_not be_removable
    end
    
    it "should not be removable if cdash_question attached" do
      Factory.create(:cdash_question, :domain => subject)
      subject.should_not be_removable
    end
  end
end
