require 'spec_helper'

describe QueriesController do

  before(:each) do
    activate_authlogic
    UserSession.create Factory.build(:user_monitor)
  end

  def mock_query(stubs={})
    @mock_query ||= mock_model(Query, stubs)
  end

  describe "GET index" do
    it "assigns all queries as @queries" do
      queries = [mock_query]
      Query.stub!(:ascend_by_id).and_return(queries)
      queries.stub!(:search).and_return(queries)
      queries.stub!(:paginate).and_return(queries)
      get :index
      assigns[:queries].should == queries
    end
  end

  describe "PUT close" do
    it "should close a query" do
      query = Factory(:query)

      put :close, :id => query.id

      query.reload.should be_closed
    end
  end


end
