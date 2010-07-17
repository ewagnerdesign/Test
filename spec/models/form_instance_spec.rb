require 'spec_helper'

describe FormInstance do
  it "should create a new instance given valid attributes" do
    form_instance = Factory(:form_instance)
    form_instance.should be_valid
    form_instance.errors.should be_empty
  end

end
