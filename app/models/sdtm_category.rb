class SdtmCategory < ActiveRecord::Base
  validates_presence_of :code
  validates_uniqueness_of :code, :case_sensitive => false
  validates_length_of :code, :maximum => 45

  validates_presence_of :name
  validates_length_of :name, :maximum => 255

  validates_presence_of :submission_value
  validates_length_of :submission_value, :maximum => 255

  validates_presence_of :cdisc_preferred_term
  validates_length_of :cdisc_preferred_term, :maximum => 255

  validates_presence_of :synonyms
  validates_length_of :synonyms, :maximum => 255

  validates_presence_of :nci_preferred_term
  validates_length_of :nci_preferred_term, :maximum => 255

  has_many :sdtm_answers
  has_many :form_fields
  has_many :cdash_questions
  
  def removable?
    !read_only && sdtm_answers.blank? && form_fields.blank? && cdash_questions.blank?
  end

  SEARCH_FIELDS = [:code, :name, :submission_value, :cdisc_preferred_term, :synonyms, :definition, :nci_preferred_term]
end
