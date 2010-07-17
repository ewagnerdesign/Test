require "spec_helper"

describe "ecrfs/new.html.erb" do


  before(:all) do
    @form_instance = Factory.create(:form).form_instances.build
    @form = Former.new(@form_instance)
    @form_data = ActiveSupport::JSON.decode(@form_instance.form.metadata)
  end

  before(:each) do
    assigns[:form_instance] = @form_instance
    assigns[:form_data] = @form_data
    assigns[:form] = @form
  end

  it "should display form " do
    render "ecrfs/new.html.erb"
    response.should have_selector("form[class='uniForm']" ) do |form|
      form.should have_tag "h1", @form_data['form']['title']
      form.should have_tag "small", @form_data['form']['description']

      form.should have_tag "fieldset" do
        pending "add all forms control"
      end
    end
  end

end
