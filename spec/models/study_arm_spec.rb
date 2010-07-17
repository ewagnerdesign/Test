require 'spec_helper'

describe StudyArm do
  #study
  it { should have_db_column(:study_id).of_type(:integer).with_options(:null => false )}
  it { should validate_presence_of(:study_id)}
  it { should belong_to(:study) }

  #code
  it { should have_db_column(:code).of_type(:string).with_options(:limit => 45, :null => false )}
  it { should have_db_index([:study_id, :code]).unique(true) }
  it { should validate_presence_of(:code)}
  it { should ensure_length_of(:code).is_at_most(45)}

  it { should have_many(:study_arm_visits) }
  it { should have_many(:visits) }

  describe ".removable" do
    subject { Factory.create(:study_arm) }

    it { should be_valid }
    its(:errors) { should be_empty }
    it { should be_removable }

    it "should not be removable if subject attached" do
      Factory.create(:subject, :study_arm => subject)
      subject.should_not be_removable
    end

    it "should be removable even if it's default study arm" do
      subject.study.default_study_arm = subject
      subject.should be_removable

      subject.destroy
      subject.study.default_study_arm.should be_nil
    end
  end
end
