class RoleStudySiteUser < ActiveRecord::Base
  belongs_to :role
  belongs_to :study_site_user

  validates_presence_of :role_id
  validates_presence_of :study_site_user_id

  # todo: validate role id must be 4
  
end
