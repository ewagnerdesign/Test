class Permission < ActiveRecord::Base
  validates_presence_of :name
  validates_length_of :name, :maximum => 100
  validates_uniqueness_of :name, :case_sensitive => false

  validates_presence_of :description
  validates_length_of :description, :maximum => 255
  validates_uniqueness_of :description, :case_sensitive => false

  validates_presence_of :category
  
  has_many :permission_roles, :dependent => :destroy
  has_many :roles, :through => :permission_roles
  
  def removable?
    roles.blank?
  end

  # named scopes
  %w(system_level study_level site_level site_study_level).each do |l|
    named_scope l.to_sym, :conditions => { :category => Role.const_get(l.upcase.to_sym) }
  end

  named_scope :by_category, lambda{ |category|
      { :conditions => { :category => category } }
    }

  SEARCH_FIELDS = [:name, :description]
end
