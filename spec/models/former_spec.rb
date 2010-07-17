require 'spec_helper'
require 'form_metadata'

describe Former, :type=> :class do

  before do
      @form = Factory.create(:form)
      @form_instance =  @form.form_versions.last.form_instances.build
      @metadata =  FD::Metadata::Form.new(@form.form_versions.last.metadata)
  end

  describe ".new" do
    subject { Former.new(@form_instance) }

    its(:form) { should eql @form }
    its(:form) { should eql @form_instance.form_version.form }
    its(:instance) { should eql @form_instance }
    its(:controls) { should have(@metadata.controls.length).controls }
    it { should be_new }

    it "should create FormerControl for each control" do
      @metadata.controls.each do |metacontrol|
        control = subject[metacontrol.control_id]
        control.should_not be_nil
      end
    end

  end

  describe '#save' do
    subject do
      returning Former.new(@form_instance) do |object|
        object.save
      end
    end

    it { should_not be_new }

    it "should save and create new form field values" do
      pending "Check this test"
      subject.instance.should have(subject.controls.length).form_field_values
    end
  end

  describe '#create' do
    subject { Former.new(@form_instance) }
    let(:metadata) { FD::Metadata::Form.new(@form.metadata) }

    it "should create form with params" do
      data = {}
      ids = []
      metadata.controls.each do |metacontrol|
        #p metacontrol.data['control']['type']
        if %w(checkbox dscheckbox dsinput).include?(metacontrol['type'])
          data[('control_'+metacontrol.control_id.to_s).to_sym] = %w(test test1)
        else
          data[('control_'+metacontrol.control_id.to_s).to_sym] = 'Test'
        end

        ids << metacontrol.control_id
      end

      subject.create(data)
      ids.each do |control|
        subject[control].should_not be_nil
        if [:checkbox, :dscheckbox, :dsinput].include?(subject[control].type)
          subject[control].value.should == %w(test test1)
        else
          subject[control].value.should == "Test"
        end
      end
    end
  end

end
