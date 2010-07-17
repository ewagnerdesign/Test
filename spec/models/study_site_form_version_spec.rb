require 'spec_helper'

describe StudySiteFormVersion do
  before(:each) do
    @valid_attributes = {
      :accepted => false,
      :study_site_id => 1,
      :form_version_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    StudySiteFormVersion.create!(@valid_attributes)
  end
end
