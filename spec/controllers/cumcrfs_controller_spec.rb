require 'spec_helper'

describe CumcrfsController do

  before(:each) do
    activate_authlogic
    UserSession.create Factory.build(:user_monitor)
    study = Factory.create(:study)
    site = Factory.create(:site)
    study.sites << site
    @form = Factory.create(:form_cumulative)
    study.forms << @form
    @subject = Factory.create(:subject, :study => study, :study_arm => study.default_study_arm, :site => site)
  end


  describe "GET list" do
    it "should return all subject's study cumulative forms" do
      Subject.should_receive(:find).with(@subject.id.to_s).and_return(@subject)
      @subject.study.should_receive(:forms).and_return([@form])

      get 'list', :subject_id => @subject.id

      assigns[:subject].should == @subject
      assigns[:forms].should == [@form]

      response.should render_template("cumcrfs/list")
      response.should be_success
    end
  end

  describe "GET index" do
    it "should return all form instances of cumulative crfs for the subject" do
      crf = Factory.create(:form_instance, :form_version => @form.form_versions.last, :subject => @subject)

      Subject.should_receive(:find).with(@subject.id.to_s).and_return(@subject)

      get 'index', :subject_id => @subject.id

      assigns[:subject].should == @subject
      assigns[:forms].should == [crf]

      response.should render_template("cumcrfs/index")
      response.should be_success
    end
  end

end
