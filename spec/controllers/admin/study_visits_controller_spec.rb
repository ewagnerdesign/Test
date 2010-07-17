require 'spec_helper'

describe Admin::StudyVisitsController do

  before(:each) do
    activate_authlogic
    UserSession.create Factory.build(:user_monitor)
  end

  describe "GET index" do
    it "assigns all visits from @study as @visits" do
      study = Factory.stub!(:study, :id => 42)
      study.should_receive(:default_study_arm).and_return(nil)

      visit = Factory.stub!(:visit_absolute)
      visit.should_receive(:study).and_return(study)
      visits = [visit]
      visits.should_receive(:ascend_by_number).and_return(visits)
      visits.should_receive(:search).and_return(visits)
      study.should_receive(:visits).and_return(visits)
      Study.should_receive(:find).with('42').and_return(visit.study)
      get :index, :study_id => 42

      assigns[:visits].should == visits
      response.should render_template('admin/study_visits/index')
    end
  end

  describe "GET show" do
    it "assigns the requested visit as @visit" do
      get_study_and_visit
      @study.should_receive(:default_study_arm).and_return(nil)

      get :show, :study_id => 42, :id => 24
      assigns[:visit].should == @visit
    end
  end

  describe "GET new" do
    it "assigns a new visit as @visit" do
      study = Factory.stub!(:study, :id => 42)
      visit = Factory.stub!(:visit_absolute)
      visit.should_receive(:study).and_return(study)
      visits = []
      Study.should_receive(:find).with('42').and_return(visit.study)
      study.should_receive(:visits).and_return(visits)
      study.should_receive(:default_study_arm).and_return(nil)

      visits.stub!(:new).and_return(visit)
      get :new, :study_id => 42
      assigns[:visit].should == visit
    end
  end

  describe "GET edit" do
    it "assigns the requested visit as @visit" do
      get_study_and_visit
      @study.should_receive(:default_study_arm).and_return(nil)

      get :edit, :study_id => 42, :id => 24
      assigns[:visit].should == @visit
    end
  end

  describe "POST create" do

    def stub_create(valid)
      @study = Factory.stub!(:study, :id => 42)
      @visits = []
      @visit = Factory.stub!(:visit_absolute)
      Study.should_receive(:find).with('42').and_return(@study)
      @study.should_receive(:visits).and_return(@visits)
      @study.should_receive(:save).and_return(valid)
      @study.should_receive(:default_study_arm).and_return(nil)
      @visits.stub!(:build).and_return(@visit)

      post :create, :study_id => 42, :visit => @visit, :format => :js
      assigns[:visit].should equal(@visit)
    end

    describe "with valid params" do
      it "assigns a newly created visit as @visit" do
        stub_create(false)
        #response.should render_template('visit')
      end
    end

#    describe "with invalid params" do
#      it "assigns a newly created but unsaved visit as @visit" do
#        Visit.stub!(:new).with({'these' => 'params'}).and_return(mock_visit(:save => false))
#        post :create, :visit => {:these => 'params'}
#        assigns[:visit].should equal(mock_visit)
#      end
#
#      it "re-renders the 'new' template" do
#        Visit.stub!(:new).and_return(mock_visit(:save => false))
#        post :create, :visit => {}
#        response.should render_template('new')
#      end
#    end

  end

  def get_study_and_visit
    @study = Factory.stub!(:study)
    @visit = Factory.stub!(:visit_absolute)
    @visit.should_receive(:study).and_return(@study)
    Study.should_receive(:find).with('42').and_return(@visit.study)

    Visit.should_receive(:find).with('24').and_return(@visit)
  end
end

