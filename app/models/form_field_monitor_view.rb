class FormFieldMonitorView < ActiveRecord::Base
  belongs_to :form_field
  belongs_to :monitor_view

  validates_presence_of :form_field
  validates_presence_of :monitor_view
  
  validate :validate_forms

  private

  def validate_forms
    return true if monitor_view.form == form_field.form_version.form
    errors.add(:form, "should be one form at MonitorView and FormField")
    return false
  end
end