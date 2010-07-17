require 'spec_helper'

describe Admin::UserStudyRolesController do

  before(:each) do
    activate_authlogic
    UserSession.create Factory.build(:user_monitor)
    
    @user = Factory.create(:user)
    @role = Factory.create(:role, :category => Role::STUDY_LEVEL)
    @user.studies << Factory.create(:study)
    @study = Factory.create(:study)
  end

  describe "GET index" do
    it "should return roles list" do
      xhr :get, :index, :user_id => @user.id
      response.should render_template("admin/user_study_roles/index")
      response.should be_success
      assigns[:user].should == @user
      assigns[:roles].should == [@role]
      assigns[:study_users].should == @user.study_users
      assigns[:study_user].should == @user.study_users.first
      assigns[:selected_roles].should == []
    end
  end

  describe "POST update" do
    it "should update user roles in Study" do
      xhr :post, :update, :user_id => @user.id, :id => @user.study_users.first.id, :roles => [@role.id]
      response.should redirect_to(:action => "index", :user_id => @user.id, :format => :js)
      
      @user.study_users.first.roles.should == [@role]
    end
  end

  describe "GET new" do
    it "should return unnasignes studies list" do
      xhr :get, :new, :user_id => @user.id
      response.should render_template("admin/user_study_roles/_new")
      response.should be_success
      assigns[:user].should == @user
      assigns[:studies].should == [@study]
    end
  end

  describe "PUT create" do
    it "should user to Study" do
      study1 = @user.studies.first
      xhr :put, :create, :user_id => @user.id, :studies => [@study.id]
      response.should redirect_to(:action => "index", :user_id => @user.id, :format => :js)
      
      @user.studies.should == [study1, @study]
    end
  end
  
  describe "GET add_sites" do
    it "should return sites list" do
      site = Factory.create(:site)
      @user.studies.first.sites = [site]
      
      xhr :get, :add_sites, :user_id => @user.id, :id => @user.study_users.first.id
      response.should render_template("admin/user_study_roles/_add_sites")
      response.should be_success
      assigns[:user].should == @user
      assigns[:study_user].should == @user.study_users.first
      assigns[:selected_sites].should == @user.study_users.first.sites
      assigns[:sites].should == [site]
    end
  end

  describe "GET assign_sites" do
    it "should assign sites to user" do
      site = Factory.create(:site)
      @user.studies.first.sites = [site]
      
      xhr :get, :assign_sites, :user_id => @user.id, :id => @user.study_users.first.id, :sites => [site]

      response.should be_success
      assigns[:study_user].should == @user.study_users.first
      @user.study_users.first.sites.should == [site]      
    end
  end
  
  
end




