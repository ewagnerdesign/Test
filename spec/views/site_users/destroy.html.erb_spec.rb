require 'spec_helper'

describe "/site_users/destroy" do
  before(:each) do
    render 'site_users/destroy'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/site_users/destroy])
  end
end
