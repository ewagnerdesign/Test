require 'spec_helper'

describe StudyArmVisit do
  #study_arm
  it { should have_db_column(:study_arm_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:study_arm_id)}
  it { should belong_to(:study_arm) }

  #visit
  it { should have_db_column(:visit_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:visit_id)}
  it { should belong_to(:visit) }

  it { should have_db_index([:study_arm_id, :visit_id]).unique(true) }

  it { should have_many(:forms) }

  it "should not be possible to attach a cumulative form to StudyArmVisit" do
    arm_visit = Factory.create(:study_arm_visit)
    arm_visit.forms += [Factory.build(:form_cumulative)]
    arm_visit.should_not be_valid
  end
end
