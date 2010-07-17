class StudyForm < ActiveRecord::Base
  belongs_to :study
  belongs_to :form

  validates_presence_of :study_id, :form_id
  validates_associated :study, :form

  validate :validate_cumulative_form

  # only cumulative forms can be assigned to study
  def validate_cumulative_form
    return true if form.cumulative?
    errors.add(:study_form, "should be attached only to a cumulative form")
    return false
  end
end
