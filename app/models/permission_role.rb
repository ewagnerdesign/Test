class PermissionRole < ActiveRecord::Base
  belongs_to :permission
  belongs_to :role

  validates_presence_of :permission_id
  validates_presence_of :role_id
end
