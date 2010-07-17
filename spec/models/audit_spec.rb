require 'spec_helper'

describe Audit do
  it "should create a new instance given valid attributes" do
    audit = Factory(:audit)
    audit.should be_valid
    audit.errors.should be_empty
  end
end
