require 'spec_helper'
require 'form_metadata'

describe FormMetadata, :type=> :class do
  before(:each) do
    @metadata = FormMetadata.new(File.read(File.dirname(__FILE__) + "/../fixtures/form_update.json"))
  end

  it "should not change struncture" do
    pending
    @metadata.to_hash.should === ActiveSupport::JSON.decode(File.read(File.dirname(__FILE__) + "/../fixtures/form_update.json"))
  end

  it "should not change field order" do
    pending
    right_order = ActiveSupport::JSON.decode(File.read(File.dirname(__FILE__) + "/../fixtures/form_update.json"))
    pending "TODO:Find the way to check the field order`"
  end
end

describe FD::Metadata::Form, :type=> :class do
  context "load" do
    subject { FD::Metadata::Form.new(File.read(File.dirname(__FILE__) + "/../fixtures/form_base.json")) }
    it { should have(7).controls }
    it { should have(3).columns }
    its(:form_id) { should == 0}

    it "should set form id" do
      subject.form_id = 5
      subject.to_hash['form']['formId'].should == 5
    end
  end
end
