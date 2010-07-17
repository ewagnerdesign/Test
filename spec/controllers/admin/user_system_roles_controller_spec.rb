require 'spec_helper'

describe Admin::UserSystemRolesController do

  before(:each) do
    activate_authlogic
    UserSession.create Factory.build(:user_monitor)
    @user = Factory.create(:user)
    @role = Factory.create(:role, :category => Role::SYSTEM_LEVEL)
  end

  describe "GET index" do
    it "should return roles list" do
      xhr :get, :index, :user_id => @user.id
      response.should render_template("admin/user_system_roles/index")
      response.should be_success
      assigns[:roles].should == [@role]
    end
  end

  describe "POST create" do
    it "should add roles to user" do
      xhr :post, :create, :user_id => @user.id, :roles => [@role.id]
      response.should redirect_to admin_user_roles_path(@user, :format => :js)

      @user.roles.should == [@role]
    end
  end
end
