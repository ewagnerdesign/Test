class StudyUser < ActiveRecord::Base
  belongs_to :study
  belongs_to :user

  has_many :role_study_users, :dependent => :destroy
  has_many :roles, :through => :role_study_users

  has_many :site_study_users, :dependent => :destroy
  has_many :sites, :through => :site_study_users

  validates_presence_of :study_id
  validates_presence_of :user_id
end
