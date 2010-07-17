require "spec_helper"

describe "users/change_password.html.erb" do

  before(:each) do
    @user = Factory.create(:user)
    assigns[:user] = @user
  end

  describe "first login user" do

    before(:each) do
      @user.first_login = true
    end

    it "should display form " do
       render "users/change_password.html.erb"
#       response.should have_tag "h1", "Set password"
       response.should have_selector("form[action='#{update_password_user_path(@user)}']" ) do |form|
         form.should_not have_tag"input#user_current_password"
         form.should have_tag"input#user_password"
         form.should have_tag"input#user_password_confirmation"
       end
    end

  end

  describe "user change password" do

    before :each do
      @user.first_login = false
    end

    it "should display form " do
      render "users/change_password.html.erb"
#      response.should have_tag "h1", "Change password"
      response.should have_selector("form[action='#{update_password_user_path(@user)}']" ) do |form|
        form.should have_tag"input#user_current_password"
        form.should have_tag"input#user_password"
        form.should have_tag"input#user_password_confirmation"
      end
    end
  end

end
