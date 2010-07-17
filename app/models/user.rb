class User < ActiveRecord::Base


  SEARCH_FIELDS = [
      :first_name, :last_name, :middle_name, :title, :address_1, :address_2,
      :city, :state_cd, :zip, :phone, :ext, :fax, :web_site, :email
  ]

  # relations
  has_many :study_users, :dependent => :destroy
  has_many :site_users, :dependent => :destroy
  has_many :studies, :through => :study_users
  has_many :sites, :through => :site_users

  has_many :role_users, :dependent => :destroy
  has_many :roles, :through => :role_users

  has_many :login_attempts
  has_many :old_passwords, :order => 'id ASC'

  # scopes

  # get all users for site
  named_scope :site_users, lambda{ |site_id|
    {
        :joins=>[:studies, :sites],
        :conditions=> {
           :sites => { :id=>site_id }
        }
     }
  }

  # get all users for study
  named_scope :study_users, lambda{ |study_id|
    {
        :joins=>[:studies],
        :conditions=> {
           :studies => { :id=>study_id }
        }
     }
  }

  named_scope :study_site_users, lambda{ |site_id,study_id|
    {
        :joins=>{ :site_users=>:study_site_users },
        :conditions=>{
          :site_users=>{
              :site_id=>site_id,
              :study_site_users=>{ :study_id=> study_id }
           }
        }
     }
  }

  # virtual attributes
  attr_accessor :current_password

  # validators
  include ::AddressValidatorsHelper::Address

  validates_presence_of :login_count
  validates_presence_of :failed_login_count

  validates_presence_of :first_name
  validates_length_of :first_name, :maximum => 255

  validates_presence_of :last_name
  validates_length_of :last_name, :maximum => 255

  validates_length_of :middle_name, :maximum => 255, :allow_nil => true

  validates_presence_of :title
  validates_length_of :title, :maximum => 255

  validates_length_of :phone, :maximum => 10, :allow_nil => true
  validates_length_of :fax, :maximum => 10, :allow_nil => true
  validates_length_of :ext, :maximum => 5, :allow_nil => true

  validates_length_of :web_site, :maximum => 255, :allow_nil => true

  validates_presence_of :time_zone
  validates_length_of :time_zone, :maximum => 255


  # callbacks

  #update phone numbers for number only
  before_validation :compact_phones

  # init password on first active user
  before_save :initialize_password, :if=> lambda{ |u| u.active? && u.password_empty? }

  after_update :save_old_password

  # init authlogic
  acts_as_authentic do |c|
    # login validators
    c.with_options :if=>:active? do |v|
      v.validates_length_of_login_field_options = {:minimum => 3}
      v.validates_format_of_login_field_options = {:with => /\A\w[\w\.+\-_@ ]+$/}
      v.validates_uniqueness_of_login_field_options = {}
    end

    # password validators
    c.ignore_blank_passwords = false
    c.with_options :if=>:force_password_changed? do |v|
      v.validates_length_of_password_field_options = { :minimum => Settings.minimum_password_length || 10}
      v.validates_length_of_password_confirmation_field_options = {:minimum => Settings.minimum_password_length || 10}
      v.validates_confirmation_of_password_field_options = {}

      v.validates_format_of :password, :with => /[a-zA-Z]+/, :message => "Should be at least one char"
      v.validates_format_of :password, :with => /[0-9]+/, :message => "Should be at least one digit"
      v.validates_format_of :password, :with => /[`~!@#\$%^&*()_+=\-{}\[\]:"|;'\\<>?,.\/]+/, :message => "Should be at least one symbol" if Settings.password_complexity.nil? || Settings.password_complexity == 1
      v.validate_on_update :check_old_password
    end

    # don't logout user when update model
    c.maintain_sessions = true
  end

  def full_name
    [first_name, middle_name, last_name].compact.join(' ').strip
  end

  def get_info
    "%s, %s" % [full_name, email]
  end

  def password_empty?
    self.crypted_password.nil? && self.password_salt.nil?
  end

  def password_expired?
    return false if Settings.password_expiration.nil? || Settings.password_expiration.zero?
    last_changed = old_passwords.empty? ? created_at : old_passwords.last.created_at # use date of last password change
    DateTime.now.new_offset - Settings.password_expiration > last_changed
  end

  def login_locked_now?
    return false unless login_locked # the user is not locked in users table
    return true if Settings.lockout_period.to_i.zero? # the lock may be disabled only manually
    Time.zone.now < login_locked + Settings.lockout_period * 60 # the lock still not expired 
  end

  # only for test and development purposes!
  # do not use for production
  def unlock(new_password)
    old_passwords.destroy_all
    self.password = self.password_confirmation = new_password
    self.login_locked = nil
    self.first_login = true
    save!
  end

  private

  def force_password_changed?
     @password_changed && active?
  end

  def initialize_password
   # init new password
   self.randomize_password

   # send letter to user
   Emailer.deliver_create_user(self)
  end

  def check_old_password
    # algorithm has been copied from http://blog.vendorrisk.com/2009/12/rails-authlogic-password-history/
    prev_passwords = old_passwords.last(Settings.password_history || 5)
    old_password_used = prev_passwords && prev_passwords.any? {|old| Authlogic::CryptoProviders::Sha512.matches?(old.crypted_password, password + old.password_salt)}
    errors.add_to_base("Password cannot be one you have used in the past") if old_password_used
  end

  def save_old_password
    return if !crypted_password_changed? && !password_salt_changed?
    old_passwords.create!(:crypted_password => crypted_password_was, :password_salt => password_salt_was)
  end
end
