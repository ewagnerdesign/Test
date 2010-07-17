require 'spec_helper'

describe Admin::StudyCumulativeCrfsController do

  before(:each) do
    activate_authlogic
    UserSession.create Factory.build(:user_monitor)
    @user = Factory.create(:user)
    @role = Factory.create(:role, :category => Role::SYSTEM_LEVEL)

    @study = Factory.create(:study)
    @form = Factory.create(:form_cumulative)
  end

  # GET index
  #----------------------------------------------------------------------------
  describe "GET index" do
    before(:each) do
      assign_form
    end

    it "should return all assigned forms" do
      xhr :get, :index, :study_id => @study.id

      assigns[:forms].should == @study.forms
      assigns[:study].should == @study
      response.should render_template("admin/study_cumulative_crfs/index")
    end
  end

  # GET show
  #----------------------------------------------------------------------------
  describe "GET show" do
    before(:each) do
      assign_form
    end

    it "should return all assigned forms" do
      xhr :get, :show, :study_id => @study.id, :id => @form.id

      assigns[:form].should == @form
      assigns[:study].should == @study
      response.should render_template("admin/study_cumulative_crfs/show")
    end
  end


  describe "GET new" do
    it "should return all forms list" do
      xhr :get, :new, :study_id => @study.id

      assigns[:forms].should == [@form]
      response.should render_template("admin/study_cumulative_crfs/new")
      response.should be_success
    end

    it "should return forms not assigned to the study" do
      form = Factory.create(:form_cumulative)
      assign_form

      xhr :get, :new, :study_id => @study.id

      assigns[:forms].should == [form]
      response.should render_template("admin/study_cumulative_crfs/new")
      response.should be_success
    end
  end

  describe "POST create" do
    it "should add forms to study" do
      xhr :post, :create, :study_id => @study.id, :forms => [@form]

      response.should render_template("admin/study_cumulative_crfs/index")
      @study.reload
      assigns[:forms].should == @study.forms
      assigns[:study].should == @study
    end
  end

  # DELETE
  #----------------------------------------------------------------------------
  describe "DELETE destroy" do
    before(:each) do
      assign_form
    end

    it "should remove the requested form from study_arm_visit" do
      xhr :delete, :destroy, :study_id => @study.id, :id => @form.id

      @study.reload
      assigns[:forms].should == @study.forms
      assigns[:study].should == @study
      response.should render_template("admin/study_cumulative_crfs/index")
    end
  end

  def assign_form
    @study.forms << @form
  end

end
