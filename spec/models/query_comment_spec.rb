require 'spec_helper'

describe QueryComment do
  before(:each) do
  end

  it "should create a new query instance given valid attributes" do
    query = Factory(:query_comment)
    query.should be_valid
    query.errors.should be_empty
  end

  context "determine the comment type" do

    it "should be of query type" do
      qc = Factory(:query_comment, :query_type => QueryComment::TYPE_QUERY)
      qc.should be_query
    end

    it "should be of reply type" do
      qc = Factory(:query_comment, :query_type => QueryComment::TYPE_REPLY)
      qc.should be_reply
    end
  end

end
