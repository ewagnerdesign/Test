require 'spec_helper'

describe FormStudyArmVisit do
  #form
  it { should have_db_column(:form_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:form_id)}
  it { should belong_to(:form) }

  #visit
  it { should have_db_column(:study_arm_visit_id).of_type(:integer).with_options(:null => false)}
  it { should validate_presence_of(:study_arm_visit_id)}
  it { should belong_to(:study_arm_visit) }

  it { should have_db_index([:form_id, :study_arm_visit_id]).unique(true) }
end


