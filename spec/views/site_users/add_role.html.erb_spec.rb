require 'spec_helper'

describe "/site_users/add_role" do
  before(:each) do
    render 'site_users/add_role'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/site_users/add_role])
  end
end
