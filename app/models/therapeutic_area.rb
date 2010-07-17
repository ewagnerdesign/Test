class TherapeuticArea < ActiveRecord::Base
  has_many :studies
  validates_presence_of :name

  find_or_create_by_autocomplete :name

  SEARCH_FIELDS = [:name]
end
