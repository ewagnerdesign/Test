class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])

    user = User.login_eq(@user_session.login).first
    locked_by_users = user.try(:login_locked_now?) || false
    locked_by_login_attempts = LoginAttempt.locked?(@user_session.login) # Maximum invalid login attempts
    locked = user ? locked_by_users : locked_by_login_attempts # known/unknown login

    if !locked && @user_session.save
      @user_session.user.login_locked = nil
      @user_session.user.save!
      if @user_session.user.first_login? 
        flash[:notice] = "You must change you password at first login"
        redirect_to change_password_user_path(@user_session.user, :html)
      elsif @user_session.user.password_expired?
        flash[:notice] = "You must change you password as old expired"
        redirect_to change_password_user_path(@user_session.user, :html)
      else
        flash[:notice] = "Login successful!"
        redirect_back_or_default(account_url, :html)
      end
      write_login_attempt = true
    else
      flash[:notice] = "The username or password you entered is incorrect or user is locked."
      @user_session.errors.clear 
      render :action => :new
      write_login_attempt = !locked_by_login_attempts # to avoid relock for impatience users 
    end

    #TODO write to log
    LoginAttempt.create!(
        :login => @user_session.login,
        :ip => request.remote_ip,
        :user_agent => request.user_agent,
        :user => @user_session.user,
        :successfull => !@user_session.new_session?
    ) if write_login_attempt
    locked_by_login_attempts = LoginAttempt.locked?(@user_session.login) # Maximum invalid login attempts
    if locked_by_login_attempts && user
      user.login_locked = Time.zone.now
      user.save!
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default(new_user_session_url, :html)
  end
end
