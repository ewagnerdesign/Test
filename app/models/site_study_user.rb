class SiteStudyUser < ActiveRecord::Base
  belongs_to :study_user
  belongs_to :site

  validates_presence_of :study_user_id
  validates_presence_of :site_id
end
