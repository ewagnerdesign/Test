require 'spec_helper'

describe EcrfsController do

  before(:each) do
    activate_authlogic
    UserSession.create Factory.build(:user_monitor)
  end

  describe "GET index" do
    it "should render template" do
      get :index
      response.should render_template("ecrfs/index")
    end
  end

  describe "GET new" do

    subject { Factory.create(:form) }

#    it "should be redirect when id is empty" do
#      get :new, :id=>nil
#      response.should_not render_template("ecrfs/new")
#      pending
#    end

    it "should render template" do
      get :new, :form_id=>subject.id
      response.should render_template("ecrfs/new")
      response.should be_success
    end
  end

  describe "Post#create" do

    before(:each) do
      fi = Factory.create :form_instance
      @post_data = {
        "form_instance" =>{
            "form_version_id"=>fi.form_version.id,
            "actual_date_time_fake"=>"13-MAY-2010", "actual_date_time(1i)"=>"2010", "actual_date_time(2i)"=>"5","actual_date_time(3i)"=>"13", "actual_date_time(4i)"=>"09", "actual_date_time(5i)"=>"23",
            "visit_id"=>fi.visit.id,
            "subject_id"=>fi.subject.id
        },
        "form" => {
            "base"=> fi.form_version.form_fields.inject({}) do |r,e|
              value = %w(checkbox dscheckbox dsinput).include?(e.field_type) ? ['']:""
              r.update( "control_#{e.id}"=>value)
            end
        }
      }
    end

    it "should save new instance" do
      post :create, @post_data
      response.should redirect_to(:action =>'index')
    end
  end

end

