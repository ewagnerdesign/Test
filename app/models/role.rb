class Role < ActiveRecord::Base

  SEARCH_FIELDS = [:name, :description]

  # types
  SYSTEM_LEVEL = 1
  STUDY_LEVEL = 2
  SITE_LEVEL = 3
  SITE_STUDY_LEVEL = 4

  CATEGORIES = [SYSTEM_LEVEL,STUDY_LEVEL, SITE_LEVEL, SITE_STUDY_LEVEL]

  has_many :permission_roles, :dependent => :destroy
  has_many :permissions, :through => :permission_roles

  has_many :role_users, :dependent => :destroy
  has_many :users, :through => :role_users

  has_many :role_site_users, :dependent => :destroy
  has_many :site_users, :through => :role_site_users

  has_many :role_study_users, :dependent => :destroy
  has_many :study_users, :through => :role_study_users

  has_many :role_study_site_users, :dependent => :destroy
  has_many :study_site_users, :through => :role_study_site_users


  # validators
  validates_presence_of :name
  validates_length_of :name, :maximum => 45
  validates_uniqueness_of :name, :case_sensitive => false

  validates_presence_of :description
  validates_length_of :description, :maximum => 255
  validates_uniqueness_of :description, :case_sensitive => false

  validates_presence_of :category

  # named scopes

  %w(system_level study_level site_level site_study_level).each do |l|
    named_scope l.to_sym, :conditions => { :category => Role.const_get(l.upcase.to_sym) }
  end

  # get user roles in a study for site
  named_scope :study_site_user_roles, lambda{ |study_id,site_id,user_id|
    {
      :joins=>{:study_site_users=>[:site_user] },
      :conditions=>{
          :study_site_users=>{
              :study_id=> study_id
          },
          :site_users => {
              :site_id => site_id,
              :user_id => user_id
          }
      }
    }
  }

  def removable?
    role_users.blank? && role_site_users.blank? && role_study_users.blank? && role_study_site_users.blank?
  end


  def site_level?
    category == SITE_LEVEL
  end

  def study_level?
    category == STUDY_LEVEL
  end

  def system_level?
    category == SYSTEM_LEVEL
  end

  def site_study_level?
    category == SITE_STUDY_LEVEL
  end

end
