require 'spec_helper'

describe Form do
  it { should belong_to(:domain) }

  # as cumulative form
  it { should have_many(:studies) }


  describe ".create" do
    subject { Factory.create(:form) }

    it { should be_valid }
    its(:errors) { should be_empty }

    it "should set form id in form metadata" do
      json = JSON::parse(subject.metadata)
      json["form"]["formId"].should == subject.id
    end

    context "form_fields" do
      it "should create from fields form metadata" do
        metadata = FD::Metadata::Form.new(File.read(File.dirname(__FILE__) + "/../fixtures/form_base.json"))
        subject.form_versions.first.should have(metadata.controls.length).form_fields
      end

      it "should set id for each control after form fields creation" do
        json = JSON::parse(subject.metadata)

        #Make controls array flat to make testing easier
        flat = flat_controls(json)
        flat.each do |control|
          control_id = control['control']['controlId']
          control_id.should_not be_blank
          subject.form_versions.first.form_fields.find( control_id ).should_not be_nil
        end
      end
    end

    context "columns" do
      it "should have virtual column ids in metadata" do
        metadata = FD::Metadata::Form.new(subject.metadata)
        col_id = metadata.controls.max{|a,b| a.control_id <=> b.control_id }.control_id
        metadata.columns.each do |col|
          col_id += 1
          col.control_id.should eql(col_id)
        end
      end
    end
  end

  describe "cumulative" do
    subject { Factory.create(:form_cumulative) }

    it { should be_valid }
    its(:errors) { should be_empty }
  end

  describe ".removable" do
    subject { Factory.create(:form) }

    it { should be_removable }

    it "should not be removable if form_instance attached" do
      subject.form_versions.last.form_instances +=
        [Factory.create(:form_instance, :form_version => subject.form_versions.last)]
      subject.should_not be_removable
    end

    it "should not be removable if site attached to form_version" do
      subject.form_versions.first.study_sites += [Factory.create(:study_site)]
      subject.should_not be_removable
    end


    it "should not be removable if monitor_view  attached" do
      subject.monitor_views += [Factory.create(:monitor_view)]
      subject.should_not be_removable
    end

  end

end

def flat_controls(controls)
  controls['controls'].inject([]) do |result,element|
    result.push(element) unless element['control'].nil?

    element['group']['columns'].each do |column|
      result += column
    end unless element['group'].nil?
    result
  end
end
