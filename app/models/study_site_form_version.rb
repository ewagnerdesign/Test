class StudySiteFormVersion < ActiveRecord::Base
  belongs_to :study_site
  belongs_to :form_version

  has_many :form_versions
  has_many :study_sites

  validates_presence_of :study_site_id, :form_version_id
end
