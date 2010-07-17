class Form < ActiveRecord::Base
  concerned_with :filtering

  attr_accessor :metadata

  has_many :form_study_arm_visits, :dependent => :destroy
  has_many :study_arm_visits, :through => :form_study_arm_visits

  # as cumulative form in study
  has_many :study_forms, :dependent => :destroy
  has_many :studies, :through => :study_forms

  has_many :monitor_views

  has_many :form_versions, :order => :id, :dependent => :destroy

  belongs_to :domain

  validate :validate_cumulative

  validates_uniqueness_of :name

  after_save :bump_version

  # if form is already assigned to a Study Site, doesn't have form instances created
  # and not taking part in any monitor view -> it is removable
  def removable?
    FormInstance.count(:conditions => { :"form_versions.form_id" => self.id},
                       :include => "form_version") == 0 &&
    StudySiteFormVersion.count(:conditions => { :"form_versions.form_id" => self.id },
                               :include => "form_version") == 0 &&
    monitor_views.blank?
  end

  def last_form_field(field_id)
    FormField.field_id_eq(field_id).form_version_form_id_eq(id).ascend_by_id.last
  end

  named_scope :all_cond

  named_scope :cumulative_forms, :conditions => { :cumulative => true }
  named_scope :noncumulative_forms, :conditions => { :cumulative => false }

  # field ids from all form versions
  def all_field_ids
    result = []
    form_versions.reverse_each {|form_version|
      form_version.form_fields.reverse_each {|form_field|
        result.insert(0, form_field.field_id) unless result.include?(form_field.field_id)
      }
    }
    return result
  end

  private

  def validate_cumulative
    return true unless cumulative
    return true if study_arm_visits.empty?
    errors.add(:cumulative, "form shouldn't be attached to any study arm visit")
    return false
  end

  def force_version?
    self.form_versions.last.try(:published?) || true
  end

  def bump_version
    if force_version?
      # TODO: Fix this dummy code :created_by_id => self.id
      version = self.form_versions.create({:metadata => @metadata, :name => name, :created_by_id => self.id })
    else
      version = self.form_versions.find(:last)
      version.update_attributes({:metadata => @metadata, :name => name})
    end
    @metadata = version.metadata
  end
end
