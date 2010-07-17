require 'spec_helper'

describe Admin::RolesController do

  before(:each) do
    activate_authlogic
    UserSession.create Factory.build(:user_monitor)
  end

  describe "GET index" do
    it "should return roles list" do
      role = Factory.create(:role)
      get :index
      response.should render_template("admin/roles/index")
      response.should be_success
      assigns[:roles].should == [role]
    end
  end

  describe "responding to GET new" do
    it "should expose a new role as @role" do
      @role = Role.new(:category => 0)

      xhr :get, :new
      assigns[:role].attributes.should == @role.attributes
      response.should render_template("admin/roles/new")
    end
  end

  describe "responding to GET edit" do

    it "should expose the requested role as @role and render [edit] template" do
      @role = Factory(:role)

      xhr :get, :edit, :id => @role.id
      assigns[:role].should == @role
      response.should render_template("admin/roles/edit")
    end
  end

  describe "responding to POST create" do
    it "should expose a newly created role as @role and render [create] template" do
      @role = Factory.build(:role)
      Role.stub!(:new).and_return(@role)

      xhr :post, :create, :role => { :name => @role.name }
      assigns(:role).name.should == @role.name
      response.should render_template("admin/roles/create")
    end
  end

  describe "responding to PUT udpate" do
    it "should update the requested role and render [update] template" do
      @role = Factory(:role)

      xhr :put, :update, :id => @role.id, :role => { :name => "Hello" }
      assigns(:role).id.should == @role.id
      assigns(:role).name.should == "Hello"
      response.should render_template("admin/roles/update")
    end
  end
end

