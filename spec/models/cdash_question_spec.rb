require 'spec_helper'

describe CdashQuestion do

  #data_collection_field
  it { should have_db_column(:data_collection_field).of_type(:string).with_options(:limit => 255, :null => false ) }
  it { should validate_presence_of(:data_collection_field)}
  it { should ensure_length_of(:data_collection_field).is_at_most(255)}

  #number
  it { should have_db_column(:number).of_type(:integer).with_options(:null => false ) }
  it { should validate_presence_of(:number)}

  #variable_name
  it { should have_db_column(:variable_name).of_type(:string).with_options(:limit => 255, :null => false ) }
  it { should validate_presence_of(:variable_name)}
  it { should ensure_length_of(:variable_name).is_at_most(255)}
  it { should have_db_index(:variable_name).unique(true) }

  #definition
  it { should have_db_column(:definition).of_type(:text).with_options(:null => false ) }
  it { should validate_presence_of(:definition)}

  #domain
  it { should have_db_column(:domain_id).of_type(:integer).with_options(:null => false ) }
  it { should validate_presence_of(:domain_id)}
  it { should belong_to(:domain) }

  #sdtm_category
  it { should have_db_column(:sdtm_category_id).of_type(:integer).with_options(:null => true ) }
  it { should_not  validate_presence_of(:sdtm_category_id)}
  it { should belong_to(:sdtm_category) }

  #completion instructions
  it { should have_db_column(:completion_instructions).of_type(:text).with_options(:null => true ) }
  it { should_not  validate_presence_of(:completion_instructions)}

  #sponsor_info
  it { should have_db_column(:sponsor_info).of_type(:text).with_options(:null => true ) }
  it { should_not  validate_presence_of(:sponsor_info)}

  #core
  it { should have_db_column(:core).of_type(:string).with_options(:limit => 255, :null => false ) }
  it { should validate_presence_of(:core)}
  it { should ensure_length_of(:core).is_at_most(255)}

  it "should create a new instance given valid attributes" do
    cdash_question = Factory(:cdash_question)
    cdash_question.should be_valid
    cdash_question.errors.should be_empty
  end
  
  describe ".removable" do
    subject { Factory.create(:cdash_question) }
    it { should be_removable }

    it "should not be removable if form_field attached" do
      Factory.create(:form_field, :cdash_question => subject)
      subject.should_not be_removable
    end
  end
end
