require 'spec_helper'

describe "/dashboard/index.html.erb" do

  it "should render a message if there're no latest activities" do
    assigns[:visits_by_week] = []
    assigns[:latest_activities] = []
    
    render "/dashboard/index.html.erb"
    response.body.should include("No recent Activities found.")
  end
end
