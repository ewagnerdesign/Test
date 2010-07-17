require 'spec_helper'

describe QueryCommentsController do

  before(:each) do
    activate_authlogic
    UserSession.create Factory.build(:user_monitor)

    @q1 = Factory(:query)
    @c1 = Factory(:query_comment, :query => @q1, :query_type => QueryComment::TYPE_QUERY)
    @c2 = Factory(:query_comment, :query => @q1, :query_type => QueryComment::TYPE_REPLY)
  end

  context "create comments" do
    before(:each) do

    end

    it "should add query type comment from monitor" do
      login(:login => 'monitor')
      query = Factory(:query, :user => current_user)

      xhr :post, :create, :query_id => query.id, :query_comment => { :comment => "hi monitor" }

      qc = query.comments.last
      qc.query_type.should == QueryComment::TYPE_QUERY
      qc.query_action.should == nil
      qc.comment.should == "hi monitor"
      qc.user.should == current_user
    end

    it "should add query type comment from investigator" do
      login(:login => 'investigator')
      query = Factory(:query, :user => current_user)

      xhr :post, :create, :query_id => query.id, :query_comment => { :comment => "hi invest", :query_action => QueryComment::ACTION_NO_CHANGES_REQUIRED }

      qc = query.comments.last
      qc.query_type.should == QueryComment::TYPE_REPLY
      qc.query_action.should == QueryComment::ACTION_NO_CHANGES_REQUIRED
      qc.comment.should == "hi invest"
      qc.user.should == current_user
    end

    it "should not add comment to the closed query" do
      login(:login => 'monitor')
      query = Factory(:query, :user => current_user, :closed => true)

      xhr :post, :create, :query_id => query.id, :query_comment => { :comment => "hi monitor" }

      response.body.should == "Error"
      query.reload.comments.count.should be_zero
    end

  end

end
