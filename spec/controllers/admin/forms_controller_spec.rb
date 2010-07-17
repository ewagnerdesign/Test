require 'spec_helper'

describe Admin::FormsController do

  before(:each) do
    activate_authlogic
    UserSession.create Factory.build(:user_monitor)
  end

  describe "POST preview" do
    it "should render template" do
      post :preview, :form=> Factory.attributes_for(:form)
      response.should render_template("admin/forms/_preview")
    end
  end


end

