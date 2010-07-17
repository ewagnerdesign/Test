class UsersController < ApplicationController
  before_filter :require_enable_password_reset, :only => [:change_password, :update_password ]
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update, :change_password, :update_password ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default(account_url, :html)
    else
      render :action => :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    #TODO check ability to change password with Settings.enable_password_reset==true by using params[:user][:password]
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  def change_password
    @user = current_user
  end

  def update_password
    @user = current_user
    begin
      unless @user.first_login? || @user.valid_password?(params[:user][:current_password])
        flash[:error] = "Incorrect current password"
        raise
      end
      raise unless @user.update_attributes(params[:user])
      flash[:notice] = @user.first_login? ? 'Password set was successfully.' : 'Password was changed successfully.'
      @user.update_attributes( :first_login=>false ) if @user.first_login?
      redirect_to(@user)
    rescue
      render :action => :change_password
    end
  end

  private

  def require_enable_password_reset
    redirect_to dashboard_path if !Settings.enable_password_reset && !current_user.first_login
    Settings.enable_password_reset == true
  end

end

