class LoginAttempt < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :ip, :user_agent

  validates_length_of :ip, :maximum => 15
  validates_length_of :user_agent, :maximum => 255

  def self.locked?(login)
    return false if Settings.maximum_invalid_login_attempts.to_i.zero?

    last_login_attempts = LoginAttempt.login_eq(login).descend_by_id
    last_login_attempts = last_login_attempts.created_at_gt(Time.zone.now - Settings.lockout_period * 60) unless Settings.lockout_period.to_i.zero?
    last_login_attempts = last_login_attempts.first(Settings.maximum_invalid_login_attempts)
    last_login_attempts && last_login_attempts.count == Settings.maximum_invalid_login_attempts && last_login_attempts.all? {|la| !la.successfull}
  end
end
