class StudySite < ActiveRecord::Base
  belongs_to :study
  belongs_to :site

  has_many :study_site_form_versions
  has_many :form_versions, :through => :study_site_form_versions

  validates_presence_of :study_id
  validates_presence_of :site_id
end
