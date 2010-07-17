require 'spec_helper'

describe DashboardController do

  before(:each) do
    activate_authlogic
    UserSession.create Factory.build(:user_monitor)
  end

  it "should render template" do
    get :index
    response.should render_template("dashboard/index")
  end

  describe "responding to GET index" do
    context "latest activities" do
      it "should return the info about the latest form instance added" do
        Factory(:form_instance)
        Factory(:query)

        changes = Audit.auditable_type_is_any("Query", "FormInstance").descend_by_id.all(:limit => 5)

        get :index
        assigns[:latest_activities].should == changes
        response.should render_template("dashboard/index")
      end

      it "should return only five latest activities" do
        #create several form instances and queries
        4.times { Factory(:form_instance) }
        2.times { Factory(:query)}
        Factory(:query)

        changes = Audit.auditable_type_is_any("Query", "FormInstance").descend_by_id.all(:limit => 5)

        get :index
        assigns[:latest_activities].should == changes
        response.should render_template("dashboard/index")
      end

    end
  end
end
