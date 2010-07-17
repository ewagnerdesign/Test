class FormField < ActiveRecord::Base
  belongs_to :form_version
  belongs_to :sdtm_category
  belongs_to :cdash_question

  has_many :form_field_values

  has_many :form_field_monitor_views
  has_many :monitor_views, :through => :form_field_monitor_views

  validate :validate_monitor_views

  private

  def validate_monitor_views
    return true if monitor_views.all?{|mv| mv.form == form_version.form}
    errors.add(:monitor_views, "all monitor views should be from specified form")
    return false
  end
end
