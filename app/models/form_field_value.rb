class FormFieldValue < ActiveRecord::Base
  before_validation_on_update :clear_monitored

  belongs_to :form_instance
  belongs_to :form_field

  has_many :queries, :order => :id

  def FormFieldValue.find_by_obj(obj)
    return form_instance_subject_id_eq(obj.id).all if obj.is_a?(Subject)
    return form_instance_visit_id_eq(obj.id).all if obj.is_a?(Visit)
    return form_instance_id_is(obj.id).all if obj.is_a?(FormInstance)
    raise "Unknown object"
  end

  private

  def clear_monitored
    self.monitored &&= !value_changed? && !override_reason_changed?
    return true
  end

end
