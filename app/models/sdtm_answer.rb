class SdtmAnswer < ActiveRecord::Base
  validates_presence_of :code
  validates_uniqueness_of :code, :scope => :sdtm_category_id, :message => "has already been taken"
  validates_length_of :code, :maximum => 45

  validates_presence_of :submission_value
  validates_length_of :submission_value, :maximum => 255

  validates_presence_of :cdisc_preferred_term
  validates_length_of :cdisc_preferred_term, :maximum => 255

  validates_presence_of :synonyms
  validates_length_of :synonyms, :maximum => 255

  validates_presence_of :nci_preferred_term
  validates_length_of :nci_preferred_term, :maximum => 255

  validates_presence_of :sdtm_category
  belongs_to :sdtm_category

  def removable?
    !read_only && FormFieldValue.form_field_id_eq(sdtm_category.form_fields).value_eq(id).blank?
  end

  SEARCH_FIELDS = [:code, :submission_value, :cdisc_preferred_term, :synonyms, :definition, :nci_preferred_term]

end
