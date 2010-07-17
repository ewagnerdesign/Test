require 'spec_helper'

describe Admin::StudyFormsController do

  before(:each) do
    activate_authlogic
    UserSession.create Factory.build(:user_monitor)
    @user = Factory.create(:user)
    @role = Factory.create(:role, :category => Role::SYSTEM_LEVEL)

    @study_arm_visit = Factory.create(:study_arm_visit)
    @form = Factory.create(:form)
    @study = @study_arm_visit.study_arm.study
  end


  # GET index
  #----------------------------------------------------------------------------
  describe "GET index" do
    before(:each) do
      assign_form
    end

    it "should return all assigned forms" do
      xhr :get, :index, :study_id => @study.id, :study_arm_visit_id => @study_arm_visit.id

      assigns[:forms].should == @study_arm_visit.forms
      assigns[:study_arm_visit].should == @study_arm_visit
      assigns[:study].should == @study
      response.should render_template("admin/study_forms/index")
    end
  end

  # GET show
  #----------------------------------------------------------------------------
  describe "GET show" do
    before(:each) do
      assign_form
    end

    it "should return all assigned forms" do
      xhr :get, :show, :study_id => @study.id, :study_arm_visit_id => @study_arm_visit.id, :id => [@form.id]

      assigns[:form].should == [@form]
      assigns[:study_arm_visit].should == @study_arm_visit
      assigns[:study].should == @study
      response.should render_template("admin/study_forms/show")
    end
  end


  describe "GET new" do
    it "should return all forms list" do
      xhr :get, :new, :study_id => @study.id, :study_arm_visit_id => @study_arm_visit.id

      assigns[:forms].should == [@form]
      assigns[:study_arm_visit].should == @study_arm_visit
      response.should render_template("admin/study_forms/new")
      response.should be_success
    end

    it "should return form related to study" do
      form = Factory.create(:form)
      study_arm_visit = Factory.create(:study_arm_visit)
      study_arm_visit.forms << form

      xhr :get, :new, :study_id => @study.id, :study_arm_visit_id => @study_arm_visit.id,
          :selected_study_id => study_arm_visit.study_arm.study.id

      assigns[:forms].should == [form]
      assigns[:study_arm_visit].should == @study_arm_visit
      response.should render_template("admin/study_forms/_form")
      response.should be_success
    end
  end

  describe "POST create" do
    it "should add forms to study_arm_visit" do
      xhr :post, :create, :study_id => @study.id, :study_arm_visit_id => @study_arm_visit.id,
          :forms => [@form]

      response.should render_template("admin/study_forms/index")
      @study_arm_visit.reload
      assigns[:forms].should == @study_arm_visit.forms
      assigns[:study_arm_visit].should == @study_arm_visit
    end
  end

  # DELETE
  #----------------------------------------------------------------------------
  describe "DELETE destroy" do
    before(:each) do
      assign_form
    end

    it "should remove the requested form from study_arm_visit" do
      xhr :delete, :destroy, :study_id => @study.id, :study_arm_visit_id => @study_arm_visit.id,
          :id => @form.id

      @study_arm_visit.reload
      assigns[:forms].should == @study_arm_visit.forms
      assigns[:study_arm_visit].should == @study_arm_visit
      response.should render_template("admin/study_forms/index")
    end
  end


  def assign_form
    @study_arm_visit.forms << @form
  end
end
