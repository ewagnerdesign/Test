require 'spec_helper'

describe UsersController do

  VALID_PASS = "new pass with_symbols12"

  {:change_password=>:get, :update_password=>:post}.each_pair do |action, method|
    describe "#{method.to_s}##{action.to_s} should be authenticated" do
      it "should fail if we are not authenticated" do
        send(method, action)
        response.should_not be_success
      end
    end
  end

  context "authenticated user" do

    before(:each) do
      Settings.enable_password_reset = true
      activate_authlogic
      @current_user =  Factory.create(:user)
      @current_user_session = UserSession.create @current_user
      @current_pass = @current_user.password
    end

    describe 'Get#change_password' do
      it "show form" do
        get :change_password
        response.should be_success
      end
    end

   describe "Post#update_password" do

     context "when first login" do
       before :each do
         current_user.update_attribute(:first_login, true)
       end

       subject{ assigns[:user] }

       it "should set new password" do
         post :update_password, :user=>{
            :password => VALID_PASS,  :password_confirmation => VALID_PASS
         }

         response.should redirect_to user_path(subject)
         subject.first_login.should be_false

         subject.errors.should be_empty
         should be_valid_password(VALID_PASS)
       end

       it "should be got fail without password confirmation" do
         post :update_password, :user => {
            :password => VALID_PASS
         }
         subject.should have(1).errors
         response.should render_template("users/change_password")
       end
     end

     context "when change password" do
       before :each do
         current_user.update_attribute(:first_login, false)
       end

       subject{ assigns[:user] }

       it "should be update password" do
         post :update_password, :user=>{
             :current_password=> @current_pass,
             :password => VALID_PASS,
             :password_confirmation=> VALID_PASS
         }
         should be_valid_password(VALID_PASS)
         response.should redirect_to user_path(current_user)
       end

       it "should be got fail when passwords not confirmed" do
         post :update_password, :user=>{
             :current_password=> @current_pass,
             :password => "",
             :password_confirmation => VALID_PASS
         }
         response.should render_template("users/change_password")
         subject.should_not be_valid
       end

       it "should have error with invalid current password" do
         post :update_password, :user =>{
             :current_password=> ""
         }
         response.should render_template("users/change_password")
         subject.should have(0).errors
         flash[:error].should =~ /current password/
       end

     end

      it "Security Policy: Enable Password Reset for User = False" do
        Settings.enable_password_reset = false
        
        post :update_password, :user=>{
             :current_password=> @current_pass,
             :password => VALID_PASS,
             :password_confirmation=> VALID_PASS
         }
         response.should redirect_to dashboard_path
      end
   end
  end


end