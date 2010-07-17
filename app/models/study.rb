class Study < ActiveRecord::Base
  after_create :create_default_arm

  has_many :study_users, :dependent => :destroy
  has_many :contacts, :through => :study_users, :class_name => "User", :source => :user

  has_many :study_sites, :dependent => :destroy
  has_many :sites, :through => :study_sites

  has_many :study_site_users, :dependent => :destroy
  has_many :site_users, :through => :study_site_users
  # cumulative forms
  has_many :study_forms, :dependent => :destroy
  has_many :forms, :through => :study_forms

  has_many :visits
  has_many :study_arms
  has_many :subjects, :dependent => :destroy

  has_many :monitor_views

  #title
  validates_presence_of :title
  validates_length_of :title, :maximum => 255

  #protocol number
  validates_presence_of :protocol_number
  validates_length_of :protocol_number, :maximum => 255

  #name
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :name, :maximum => 45

  #drug_name
  validates_presence_of :drug_name
  validates_length_of :drug_name, :maximum => 255

  #therapeutic_area
  validates_presence_of :therapeutic_area_id
  belongs_to :therapeutic_area

  belongs_to :default_study_arm, :class_name => "StudyArm"

  #expected sites number
  validates_numericality_of :expected_sites_number, :allow_nil => true

  #dates
  validates_presence_of :fpfv, :lplv, :expected_db_lock

  #fpfv < lplv < db_lock dates
  validate :dates_sequence

  autocomplete_for('therapeutic_area','name', :create => true)

  has_many :users, :through => :study_users

  def to_label
    title || "" #TODO: Change this stub for smth appropriate
  end

  def site_contacts(site_id)
    site_users.site_id_eq(site_id)
  end

  def removable?
    visits.blank? && study_arms.blank? && subjects.blank? && monitor_views.blank?
  end

  SEARCH_FIELDS = [:name, :title, :protocol_number, :drug_name, :expected_sites_number]

  protected

  # fpfv < lplv < expected_db_lock
  def dates_sequence
    [:fpfv, :lplv, :expected_db_lock].each do |d|
      unless send(d).instance_of?(Date)
        errors.add(d, "Must be valid Date")
        return false
      end
    end

    unless fpfv < lplv
      errors.add(:fpfv, "Must be less than lplv")
      return false
    end

    unless expected_db_lock > lplv
      errors.add(:expected_db_lock, "Must be greater than lplv")
      return false
    end

    return true
  end

  private

  def create_default_arm
    return if self.default_study_arm
    self.default_study_arm = study_arms.create!(:code => 'Default')
    self.save!
  end

end
