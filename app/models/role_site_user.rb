class RoleSiteUser < ActiveRecord::Base
  belongs_to :role
  belongs_to :site_user

  validates_presence_of :role_id
  validates_presence_of :site_user_id
end
