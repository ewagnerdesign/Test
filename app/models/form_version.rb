class FormVersion < ActiveRecord::Base
  belongs_to :form
  belongs_to :created_by, :class_name => "User"

  has_many :form_instances, :dependent => :destroy
  has_many :form_fields, :dependent => :destroy

  has_many :study_site_form_versions
  has_many :study_sites, :through => :study_site_form_versions

  validates_presence_of :metadata, :name
  validates_length_of :name, :maximum => 45

  validate :must_be_valid_json

  after_save :set_metadata_ids, :drop_just_created

  def set_metadata_ids
    form = FD::Metadata::Form.new(metadata)#FormMetadata.new(metadata)
    available_controls = form_fields.map(&:id)
    form.form_id = self.form.id
    form.form_version = self.id
    #Create new form field for added controls
    form.controls.map do |control|
      available_controls.delete(control.control_id)
      save_field(control)
    end

    #Remove deleted controls
    FormField.destroy(available_controls) unless available_controls.empty?
    self.metadata = form.to_json

    #Update database
    FormVersion.update_all({:metadata => form.to_json}, :id => self.id)
  end

  def save_field(control)
    control_data = control.metadata
    form_field = {
              :field_type => control_data['type'],
              :options => control_data['options'],
              :validators => control_data['validators'],
              :label => control_data['options']['label']
            }
    form_field.update(
        :description => RedCloth.new( control_data['options']['description'] ).to_html
    )  if control_data['options'].key?('description')

    form_field.update(
      :sdtm_category_id => control_data['options']['cdash']
    ) if control_data['options'].key?('cdash')

    form_field.update(
      :cdash_question_id => control_data['options']['cdash_question_id']
    ) if control_data['options'].key?('cdash_question_id')

    if control.new?
      # create a new control within existing version
      field = form_fields.create(form_field)
      field.update_attribute(:field_id, field.id)
      control.control_id = field.id
    elsif self.just_created?
      # new version anyway recreate form_field(s)
      previous_field = FormField.find(control.control_id)
      field = form_fields.create(form_field.merge(:field_id => previous_field.field_id))
      control.control_id = field.id
    else
      # update existing
      form_fields.update( control.control_id, form_field )
    end

    control
  end

  def drop_just_created
    update_attribute(:just_created, false) if just_created?
  end

  def published?
    self.study_site_form_versions.count > 0
  end

  def removable?
    form_instances.empty? && study_sites.empty?
  end
  
  private

  def must_be_valid_json
    begin
      data = ActiveSupport::JSON::decode(metadata)
      if data['controls'].nil?
        errors.add(:metadata,"structure is invalid")
        return false
      end
      return true
    rescue StandardError
      errors.add(:metadata,"seems to be not valid JSON")
      return false
    end
  end

end
