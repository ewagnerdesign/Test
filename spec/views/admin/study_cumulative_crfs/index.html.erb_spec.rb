require 'spec_helper'

describe "/admin/study_cumulative_crfs/index" do
  before(:each) do
    render 'admin/study_cumulative_crfs/index'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/admin/study_cumulative_crfs/index])
  end
end
