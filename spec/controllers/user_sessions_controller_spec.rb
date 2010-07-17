require 'spec_helper'

shared_examples_for "process invalid login attempts for registered user" do
  before :each do
    Settings.maximum_invalid_login_attempts = 2
    create_user :first_login => false
  end

  it "lock" do
    # first login - wrong pass
    post :create, :user_session => @wrong_signin_data
    response.should render_template("user_sessions/new")

    # second login - wrong pass
    post :create, :user_session => @wrong_signin_data
    response.should render_template("user_sessions/new")

    # third login - correct pass, but user should be already locked
    post :create, :user_session => @signin_data
    response.should render_template("user_sessions/new")
  end

  it "unlock after lock" do
    # two tries with incorrect password 
    post :create, :user_session => @wrong_signin_data
    post :create, :user_session => @wrong_signin_data
    # the user should be locked to this time - it checked by previous test

    # unlock user
    @user.reload
    @user.unlock(@signin_data[:password])

    @user.reload

    # should be correct login
    post :create, :user_session => @signin_data
    response.should redirect_to(change_password_user_url(@user, :format => :html))

    # change password
    new_signin_data = @signin_data
    new_signin_data[:password] = "qwerty_12345"
    @user.password = @user.password_confirmation = new_signin_data[:password]
    @user.save!

    2.times do # just in case
      #logout
      delete :destroy
      response.should redirect_to(new_user_session_url)

      #login should be possible
      post :create, :user_session => new_signin_data
      response.should redirect_to(change_password_user_url(@user, :format => :html))
    end
  end

  it "correct pass after wrong" do
    # first login - wrong pass
    post :create, :user_session => @wrong_signin_data
    response.should render_template("user_sessions/new")

    # second login - correct pass, should login without errors
    post :create, :user_session => @signin_data
    response.should redirect_to(account_url)
  end
end

shared_examples_for "process invalid login attempts for unregistered user" do
  it "Maximum Invalid Login Attempts - lock for unknown user" do
    # first login - wrong username
    post :create, :user_session => @wrong_signin_data
    response.should render_template("user_sessions/new")

    # second login - wrong username
    post :create, :user_session => @wrong_signin_data
    response.should render_template("user_sessions/new")

    # third login - wrong username, user should be locked
    post :create, :user_session => @wrong_signin_data
    response.should render_template("user_sessions/new")
  end
end

describe UserSessionsController do

  describe "post#create" do

    def create_user(user_attributes={})
      @user = Factory.create(:user_monitor, user_attributes)
      @signin_data = {:password => @user.password, :login => @user.login }
      @wrong_signin_data = {:password => "wrong_password", :login => @user.login }
    end

    subject{ assigns[:user_session] }

    it "should show error message " do
      post :create
      response.should render_template("user_sessions/new")
      
      # errors are disabled in controller to avoid separation of unknown user and user with wrong password
      # should have(1).errors

      flash[:notice].should_not be_empty 
    end


    context "when user first login" do
      before :each do
         create_user :first_login=>true
      end

      subject{ assigns[:user_session] }

      it "should be redirect to change password" do
        post :create, :user_session=>@signin_data
        response.should redirect_to( change_password_user_path(@user,:html) )
      end

      it "should call login attempt" do
        LoginAttempt.should_receive(:create!).
            with({
              :login => @user.login,
              :ip => request.remote_ip,
              :user_agent => request.user_agent,
              :user => @user,
              :successfull => true
            })
        post :create, :user_session=>@signin_data
        response.should be_redirect
      end

    end

    it "when user more than first login - should be redirect to show profile" do
      create_user :first_login => false
      post :create, :user_session => @signin_data
      response.should redirect_to(account_url)
    end

    it "password expiration - should be redirect to SetPassword" do
      Settings.password_expiration = 30
      create_user :first_login => false, :created_at => Time.new - 100 * 24 * 60 * 60

      post :create, :user_session => @signin_data
      response.should redirect_to( change_password_user_path(@user,:html) )
    end

    describe "Maximum Invalid Login Attempts with setted lockout period" do
      before :each do
        Settings.lockout_period = 5
      end

      it_should_behave_like "process invalid login attempts for registered user"
      it_should_behave_like "process invalid login attempts for unregistered user"
    end

    describe "Maximum Invalid Login Attempts with empty lockout period" do
      before :each do
        Settings.lockout_period = nil
      end

      it_should_behave_like "process invalid login attempts for registered user"
      it_should_behave_like "process invalid login attempts for unregistered user"
    end
  end
end