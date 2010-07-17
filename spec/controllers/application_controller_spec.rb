require 'spec_helper'

describe ApplicationController do


  [EcrfsController, DashboardController].each do |controller|

    context controller do
      describe "require ssl" do
        before :each do
          Rails.stub!(:env).and_return('production') # ssl used only in production mode
          @controller= controller.new

          # user login
          activate_authlogic
          UserSession.create Factory.build(:user)
        end

        it "should use ssl for default action" do
          pending "postponed"

          @request.env['HTTPS'] = 'on'
          get :index , :protocol=>"https://"
          response.should be_success
          request.should be_ssl
        end

        it "should required https " do
          get :index, :protocol=>"http://"
          response.should redirect_to :protocol=>"https://"
        end
      end

      describe "require login" do
        before :each do
          @controller = controller.new
        end

        it "user should be logged in" do
          get :index
          response.should redirect_to  "/user_session/new"
        end
      end
    end
  end

end
