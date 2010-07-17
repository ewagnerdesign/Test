class Domain < ActiveRecord::Base
  validates_presence_of :code
  validates_length_of :code, :in => 2..2
  validates_uniqueness_of :code, :case_sensitive => false
  
  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_uniqueness_of :name, :case_sensitive => false

  validates_presence_of :domain_class
  validates_length_of :domain_class, :maximum => 255

  has_many :cdash_questions
  has_many :forms

  def removable?
    cdash_questions.blank? && forms.blank?
  end

  SEARCH_FIELDS = [:code, :name, :domain_class, :description]
end
