class SiteUser < ActiveRecord::Base
  has_many :role_site_users, :dependent => :destroy
  has_many :roles, :through => :role_site_users

  has_many :study_site_users, :dependent => :destroy
  has_many :studies, :through => :study_site_users

  has_many :role_study_site_users, :through => :study_site_users

  belongs_to :site
  belongs_to :user

  validates_presence_of :site_id
  validates_presence_of :user_id


  SEARCH_FIELDS = User::SEARCH_FIELDS.map {|f| "user_#{f}".to_sym}


end
