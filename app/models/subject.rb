class Subject < ActiveRecord::Base

  #study
  validates_presence_of :study
  belongs_to :study

  #site
  validates_presence_of :site
  validate :validate_site
  belongs_to :site

  #study_arm
  validates_presence_of :study_arm
  belongs_to :study_arm

  has_many :form_instances

  validates_presence_of :number, :gender, :dob, :consent_datetime
  validates_numericality_of :number
  validates_uniqueness_of :number, :scope => :study_id, :message => "has already been taken"
  validates_numericality_of :randomization_number, :allow_nil => true #:unless => Proc.new { |s| s.randomization_number.blank? }

  def removable?
    form_instances.blank?
  end

  SEARCH_FIELDS = [:number]
  SEARCH_CONDITIONS = {
    :study_id => :study_id_eq,
    :study_arm_id => :study_arm_id_eq,
    :subject_id => :id_eq,
    :visit_id => :study_arm_visits_id_eq,
    :site_id => :site_id_eq,
    :only_with_open_queries => :form_instances_form_field_values_queries_not_closed
    }

  def before_destroy
    if !removable?
      errors.add("subject", "cannot delete subject with crfs assigned") 
      return false
    end
  end

  def consent_datetime_fake=(value)
  end

  private

  def validate_site
    return true if study.nil? || site.nil? || study.sites.include?(site)
    errors.add(:site, "should be linked with specified study")
    return false
  end
end


