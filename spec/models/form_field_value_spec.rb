require 'spec_helper'

describe FormFieldValue do
  it "should create a new instance given valid attributes" do
    @form_field_value = Factory(:form_field_value)
    @form_field_value.should be_valid
    @form_field_value.errors.should be_empty
  end

  describe :monitored do
    let(:form_field_value) { Factory.create(:form_field_value, :value => 1, :monitored => true) }

    it "should be cleared after changing value" do
      form_field_value.monitored.should eql(true)
      form_field_value.value = 2 # "Monitored" should be cleared
      form_field_value.save
      form_field_value.monitored.should eql(false)
    end
    
    it "should be cleared after changing override_reason" do
      form_field_value.monitored.should eql(true)
      form_field_value.override_reason = "test" # "Monitored" should be cleared
      form_field_value.save
      form_field_value.monitored.should eql(false)
    end
  end
end
