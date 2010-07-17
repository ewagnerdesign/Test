require 'spec_helper'

describe MonitorView do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    monitor_view = Factory(:monitor_view)
    monitor_view.should be_valid
    monitor_view.errors.should be_empty
  end

  it "should allow to link FormFields from one Form" do
    monitor_view = Factory(:monitor_view, :form => Factory(:form))
    form_version = monitor_view.form.form_versions[0]
    monitor_view.form_fields = [
      Factory(:form_field, :form_version => form_version),
      Factory(:form_field, :form_version => form_version)]

    monitor_view.should be_valid
    monitor_view.errors.should be_empty
  end

  it "should NOT allow to link two FormFields from other Forms" do
    monitor_view = Factory(:monitor_view, :form => Factory(:form))
    expect {
      monitor_view.form_fields = [Factory(:form_field, :form_version => Factory(:form_version))]
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  #name
  it { should have_db_column(:name).of_type(:string).with_options(:limit => 45, :null => true )}
  it { should validate_presence_of(:name)}
  # study
  it { should validate_presence_of(:study_id)}
  # form
  it { should validate_presence_of(:form_id)}
  # form_fields
  it {should have_many(:form_fields) }
end
