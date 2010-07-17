require 'spec_helper'

describe FormVersion do
  it { should have_many(:form_fields) }

  describe ".create" do
    subject { Factory.create(:form_version) }

    it { should be_valid }
    its(:errors) { should be_empty }


    it "should set form id in form metadata" do

      json = JSON::parse(subject.metadata)
      json["form"]["formId"].should == subject.form.id
    end

    context "form_fields" do
      it "should create from fields form metadata" do
        metadata = FD::Metadata::Form.new(File.read(File.dirname(__FILE__) + "/../fixtures/form_base.json"))
        subject.should have(metadata.controls.length).form_fields
      end

      it "should set id for each control after form fields creation" do
        json = JSON::parse(subject.metadata)

        #Make controls array flat to make testing easier
        flat = flat_controls(json)
        flat.each do |control|
          control_id = control['control']['controlId']
          control_id.should_not be_blank
          subject.form_fields.find( control_id ).should_not be_nil
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

  describe "#update" do

    # TODO subject.form.form_versions.count == 2, should be 1
    subject { Factory.create(:form_version) }

    def update_metadata_shash(old_metadata, options)
      shash = JSON::parse( old_metadata )
      if options.key?(:delete)
          shash['controls'].delete_at( options[:delete] )
      end
      if options.key?(:add_json)
        shash['controls'] <<  JSON::parse( options[:add_json] )
      end
      if options.key?(:update_control)
        update = options[:update_control]
        if [:option_name, :option_value].find { |e| !update.key?(e) }
          raise "invalid update options"
        end

        control = shash['controls'][ update[:num] ]['control']
        control['options'][ update[:option_name] ] = update[:option_value ]
      end

      shash.to_json
    end

    context "controls" do

      def update_metadata(options)
        new_metadata = update_metadata_shash(subject.metadata, options)
        subject.update_attributes(:metadata => new_metadata)
      end

      it "should remove form_fields was deleted control in metadata" do
        expect {
          update_metadata(:delete=>4) # delete fourth control
        }.to change( subject.form_fields, :count).by(-1)
      end

      it "should remove nested form_fields was deleted column in metadata" do
        expect {
          update_metadata(:delete=>1) # delete second control ( its group with 2 nested controls)
        }.to change( subject.form_fields, :count).by(-2)
      end

      it "should not remove any form_fields was deleted empty column in metadata" do
        expect {
          update_metadata(:delete=>5) # delete empty group
        }.to change( subject.form_fields, :count).by(0)
      end

      it "should add new form_fields was add new control in metadata" do
        expect {
          update_metadata(
             :add_json=> File.read( Rails.root + "spec/fixtures/form_add_control.json")
          )
        }.to change( subject.form_fields, :count).by(+1)
      end

      it "should set controlId for new fields in metadata" do
        update_metadata(
           :add_json=> File.read( Rails.root + "spec/fixtures/form_add_control.json")
        )
        json = JSON::parse(subject.metadata)
        json['controls'].last['control']['controlId'].should > 0
      end

      %w(label description).each do |field_name|
        it "should update '#{field_name}' options for fields in metadata" do
          new_text = "This is updated text field"
          update_metadata(
             :update_control => {
                 :num => 2,
                 :option_name => field_name,
                 :option_value => new_text
            }
          )
          json = JSON::parse(subject.metadata)
          json['controls'][2]['control']['options'][field_name].should == new_text
        end
      end

      it "checks autocreating FormVersions" do
        # create form with seven controls
        form = Factory.create(:form, :metadata => File.read(File.dirname(__FILE__) + "/../fixtures/form_base.json"))
        form.form_versions.count.should == 1
        form.form_versions.first.form_fields.count.should == 7

        # add study_site_form_ver to create new FormVersion on next save 
        Factory.create(:study_site_form_version, :form_version => form.form_versions.first)

        # remove one control, update other, add new
        metadata = form.metadata
        metadata = update_metadata_shash(metadata, :delete => 4) # delete fourth control
        metadata = update_metadata_shash(metadata, :update_control => {
                 :num => 2,
                 :option_name => 'label',
                 :option_value => 'new_text'
            }) # update
        metadata = update_metadata_shash(metadata, :add_json=> File.read( Rails.root + "spec/fixtures/form_add_control.json"))
        form.metadata = metadata
        form.save!

        # check - form_vers.count==7, form_vers[0].form_fields.count==7, form_vers[1].form_fields.count==7, all_form_fields.cnt==8
        form.form_versions.count.should == 2
        form.form_versions.last.form_fields.count.should == 7
        form.all_field_ids.count.should == 8
        used_field_ids =
          form.form_versions.first.form_fields.map {|ff| ff.field_id} +
          form.form_versions.last.form_fields.map {|ff| ff.field_id}
        form.all_field_ids.sort.should == used_field_ids.uniq.sort
      end
      
      #Order in forms is preserved so hardcoding for now

    end

    context "connections" do
      it "should remove connections was deleted in metadata" do
        pending
      end
    end

#    it "should check can we modify this form" do
#      pending #Update this spec when info arrives
#    end
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
