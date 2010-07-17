require "spec_helper"

describe "admin/forms/_preview.html.erb" do


  before(:all) do
    @form = Factory.create(:form)
    @form_instance = FormInstance.new
    @form_instance.form = @form
    @form_data = ActiveSupport::JSON.decode( @form.metadata )
  end

  before(:each) do
    assigns[:form] = Former.new(@form_instance)
    assigns[:form_data] = @form_data 
  end

  it "should display form " do
    render "admin/forms/_preview.html.erb"
    response.should have_selector("form[class='uniForm']" ) do |form|
      form.should have_tag "h1", @form_data['form']['title']
      form.should have_tag "small", @form_data['form']['description']

      form.should have_tag "fieldset" do
        pending "add all forms control"
      end
    end
  end

end
