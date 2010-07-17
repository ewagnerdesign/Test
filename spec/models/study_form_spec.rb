require 'spec_helper'

describe StudyForm do
  subject { Factory.create(:study_form, :form => Factory.create(:form_cumulative))}
  #study
  it { should have_db_column(:study_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:study_id)}
  it { should belong_to(:study) }

  #form
  it { should have_db_column(:form_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:form_id)}
  it { should belong_to(:form) }

  it "should not be possible to attach a non cumulative form to StudyForm" do
    study_form = Factory.build(:study_form)
    study_form.should_not be_valid
  end
end
