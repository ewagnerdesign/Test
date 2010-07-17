class MonitorView < ActiveRecord::Base
  belongs_to :study
  belongs_to :form

  has_many :form_field_monitor_views
  has_many :form_fields, :through => :form_field_monitor_views

  validates_presence_of :name
  validates_presence_of :study_id
  validates_presence_of :form_id

  validate :validate_form_fields

  named_scope :all_cond

  SEARCH_FIELDS = []
  SEARCH_CONDITIONS = {
    :study_id => :study_id_eq,
    :study_arm_id => :form_visits_study_arms_id_eq,
    :form_id => :form_id_eq,
    :visit_id => :form_visits_id_eq,
    :site_id => :form_visits_study_arms_subjects_site_id_eq
  }

  def field_ids
    form_fields.map{|ff| ff.field_id}.uniq
  end

  private

  def validate_form_fields
    return true if form_fields.all?{|ff| ff.form_version.form == form}
    errors.add(:form_fields, "all form fields should be from specified form")
    return false
  end

end
