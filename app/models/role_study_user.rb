class RoleStudyUser < ActiveRecord::Base
  belongs_to :role
  belongs_to :study_user

  validates_presence_of :role_id
  validates_presence_of :study_user_id
end
