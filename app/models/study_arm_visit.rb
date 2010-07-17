class StudyArmVisit < ActiveRecord::Base
  belongs_to :study_arm
  belongs_to :visit

  has_many :form_study_arm_visits, :dependent => :destroy
  has_many :forms, :through => :form_study_arm_visits

  validates_presence_of :study_arm_id
  validates_presence_of :visit_id

  validate :validate_cumulative_forms

  def validate_cumulative_forms
    return true if forms.all?{|f| !f.cumulative}
    errors.add(:study_arm_visit, "shouldn't be attached to cumulative form")
    return false
  end


end
