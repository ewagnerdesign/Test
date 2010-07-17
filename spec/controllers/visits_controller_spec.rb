require 'spec_helper'

describe VisitsController do
  before(:each) do
    activate_authlogic
    UserSession.create Factory.build(:user_monitor)
  end

  def mock_visit(stubs={})
    @mock_visit ||= mock_model(Visit, stubs)
  end

  describe "GET index" do
    it "assigns all visits as @visits" do
      visits = [Factory.stub(:visit)]
      Visit.stub!(:ascend_by_id).and_return(visits)
      visits.stub!(:search).and_return(visits)
      visits.stub!(:paginate).and_return(visits)
      get :index
      assigns[:visits].should == visits
    end

  end

end

