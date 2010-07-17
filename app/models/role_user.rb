class RoleUser < ActiveRecord::Base
  belongs_to :role
  belongs_to :user

  validates_presence_of :role_id
  validates_presence_of :user_id
end
