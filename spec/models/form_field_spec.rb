require 'spec_helper'

describe FormField do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    @form_field = Factory(:form_field)
    @form_field.should be_valid
    @form_field.errors.should be_empty
  end

  it "should allow to link FormField to a MonitorView with correct view's form" do
    form_field = Factory(:form_field)
    form_field.monitor_views = [Factory(:monitor_view, :form => form_field.form_version.form)]

    form_field.should be_valid
    form_field.errors.should be_empty
  end

  it "should NOT allow to link FormField to a MonitorView with different form" do
    form_field = Factory(:form_field)
    expect {form_field.monitor_views = [Factory(:monitor_view)]}.to raise_error(ActiveRecord::RecordInvalid)
  end
end
