require 'spec_helper'

describe FormFieldMonitorView do
  it "should allow to link a FormField to a MonitorView with correct form" do
    form_field_monitor_view = Factory.build(:form_field_monitor_view)
    form_field_monitor_view.form_field = Factory(:form_field)
    form_field_monitor_view.monitor_view = Factory(:monitor_view, :form => form_field_monitor_view.form_field.form_version.form)

    form_field_monitor_view.should be_valid
    form_field_monitor_view.errors.should be_empty
  end

  it "should NOT allow to link a FormField to a MonitorView with other form" do
    form_field_monitor_view = Factory.build(:form_field_monitor_view)
    form_field_monitor_view.form_field = Factory(:form_field)
    form_field_monitor_view.monitor_view = Factory(:monitor_view)

    form_field_monitor_view.should_not be_valid
    form_field_monitor_view.errors.should_not be_empty
  end
end
