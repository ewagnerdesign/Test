require 'spec_helper'

describe MonitorViewsController do

  before(:each) do
    activate_authlogic
    UserSession.create Factory.build(:user_monitor)
  end

  def mock_monitor_view(stubs={})
    @mock_monitor_view ||= mock_model(MonitorView, stubs)
  end

  describe "GET index" do
    it "assigns all monitor_views as @monitor_views" do
      monitor_views = [mock_monitor_view]
      MonitorView.stub!(:ascend_by_id).and_return(monitor_views)
      monitor_views.stub!(:search).and_return(monitor_views)
      monitor_views.stub!(:paginate).and_return(monitor_views)
      get :index
      assigns[:monitor_views].should == monitor_views
    end
  end

  describe "GET new" do
    it "should expose a new view as @monitor_view and render new template" do
      MonitorView.stub!(:new).and_return(mock_monitor_view)

      xhr :get, :new

      assigns[:monitor_view].should == mock_monitor_view
      response.should render_template("monitor_views/new")
    end
  end


  describe "GET 'create'" do
    it "should expose a newly created view as @monitor_view" do
      @monitor_view = Factory.build(:monitor_view, :name => "monitor")
      MonitorView.stub!(:new).and_return(@monitor_view)

      xhr :post, :create, :monitor_view => { :name => @monitor_view.name, :study_id => @monitor_view.study_id, :form_id => @monitor_view.form_id }

      assigns(:monitor_view).should == @monitor_view
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      @monitor_view = Factory.create(:monitor_view)
      get 'show', :id => @monitor_view.id
      response.should be_success
      assigns(:monitor_view).should == @monitor_view
    end
  end


  describe "PUT update" do

    it "should update only monitor view name" do
      study1 = Factory.create(:study)
      study2 = Factory.create(:study)
      form1 = Factory.create(:form)
      form2 = Factory.create(:form)
      @monitor_view = Factory.create(:monitor_view, :name => "Old monitor view", :study => study1, :form => form1)

      xhr :put, :update, :id => @monitor_view.id, :monitor_view => { :name => "Hello", :study_id => study2.id, :form_id => form2.id }

      @monitor_view.reload
      @monitor_view.name.should == "Hello"
      @monitor_view.study.should == study1
      @monitor_view.form.should == form1
    end

  end

end
