require 'spec_helper'

describe Query do
  before(:each) do
  end

  it "should create a new query instance given valid attributes" do
    query = Factory(:query)
    query.should be_valid
    query.errors.should be_empty
  end

  it "should add a new query only when a previous query is closed or not available" do
    q1 = Factory(:query)
    q1.close(current_user)
    q2 = Factory(:query, :form_field_value => q1.form_field_value)
    q2.should be_valid
    q2.errors.should be_empty
  end

  context "closing" do
    before(:each) do
      @q1 = Factory(:query)
      login(:login => 'monitor')
      @q1.close(current_user)
    end

    it "should assign current user when it's closed" do
      @q1.closed_by.login.should == 'monitor'
    end

    it "should have closed status" do
      @q1.should be_closed
    end
  end


  context "named scopes" do
    before(:each) do
      @q1 = Factory(:query, :closed => true)
      @q2 = Factory(:query, :closed => false)
    end

    it "should find all queries" do
      Query.all.should == [@q1,@q2]
    end

    it "should find open queries" do
      Query.opened.should == [@q2]
    end

    it "should find closed queries" do
      Query.closed.should == [@q1]
    end
  end

  context "replied status" do
    subject { Factory(:query) }

    it "should be true when there are no comments" do
      subject.need_reply?.should be_true
    end

    it "should be true when the last comment is query" do
      Factory(:query_comment, :query => subject)
      subject.need_reply?.should be_true
    end

    it "should be false when the last comment is reply" do
      Factory(:query_comment, :query => subject)
      Factory(:query_comment_reply, :query => subject)
      subject.need_reply?.should be_false
    end

    it "should be true when the last comment in chain is query" do
      Factory(:query_comment, :query => subject)
      Factory(:query_comment_reply, :query => subject)
      Factory(:query_comment, :query => subject)
      subject.need_reply?.should be_true
    end

    it "should be false when the last comment is reply" do
      Factory(:query_comment, :query => subject)
      Factory(:query_comment_reply, :query => subject)
      Factory(:query_comment, :query => subject)
      Factory(:query_comment_reply, :query => subject)
      subject.need_reply?.should be_false
    end
  end

  context "multiple queries for a form_field_value" do
    before(:each) do
      @q1 = Factory(:query)
      @q1.close(current_user)
      @q2 = Factory(:query, :form_field_value => @q1.form_field_value)
      @q2.close(current_user)
      @q3 = Factory(:query, :form_field_value => @q1.form_field_value)
    end

    it "should return the last query" do
      @q1.last_for_value.should == @q3
    end

    it "should return previous queries for a middle query" do
      @q2.previous_queries.should == [@q1]
    end

    it "should return previous queries for the last query" do
      @q3.previous_queries.should == [@q1, @q2]
    end
  end

end
