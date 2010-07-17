class Site < ActiveRecord::Base
  has_many :study_sites, :dependent => :destroy
  has_many :studies, :through => :study_sites

  has_many :site_users, :dependent => :destroy
  has_many :contacts, :through => :site_users, :class_name => "User", :source => :user

  has_many :site_study_users, :dependent => :destroy
  has_many :study_users, :through => :site_study_users

  has_many :subjects

  #name
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_length_of :name, :maximum => 45

  #number
  validates_length_of :number, :maximum => 45, :allow_nil => true

  #investigator
  validates_length_of :investigator, :maximum => 45, :allow_nil => true

  #active
  validates_presence_of :active

  #name
  validates_length_of :time_zone, :maximum => 255, :allow_nil => true

  acts_as_audited

  include ::AddressValidatorsHelper::Address

  has_many :users, :through => :site_users

  SEARCH_FIELDS = [:name, :investigator, :number, :city, :address_1, :address_2, :state_cd, :phone, :fax, :ext, :zip]

  #update phone numbers for number only
  def before_validation
    compact_phones
  end

  def removable?
    study_sites.blank? && site_users.blank? && site_study_users.blank? && subjects.blank?
  end
end


