class FormStudyArmVisit < ActiveRecord::Base
  belongs_to :form
  belongs_to :study_arm_visit

  validates_presence_of :form_id, :study_arm_visit_id
end
