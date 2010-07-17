class CdashQuestion < ActiveRecord::Base
  belongs_to :domain
  belongs_to :sdtm_category

  validates_presence_of :data_collection_field
  validates_length_of :data_collection_field, :maximum => 255

  validates_presence_of :domain_id
  validates_presence_of :number

  validates_presence_of :variable_name
  validates_length_of :variable_name, :maximum => 255
  validates_uniqueness_of :variable_name, :case_sensitive => false

  validates_presence_of :core
  validates_length_of :core, :maximum => 255

  validates_presence_of :definition

  has_many :form_fields
  
  def removable?
    form_fields.blank?
  end

  SEARCH_FIELDS = [:data_collection_field, :variable_name, :definition, :completion_instructions, :sponsor_info, :core]
end
