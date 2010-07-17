class StudyArm < ActiveRecord::Base

  has_many :study_arm_visits, :dependent => :destroy
  has_many :visits, :through => :study_arm_visits
  has_many :subjects

  validates_presence_of :code
  validates_length_of :code, :maximum => 45
  validates_uniqueness_of :code, :scope => :study_id, :message => "has already been taken"

  validates_presence_of :study_id
  belongs_to :study
#  validate :code_uniq

  def default_study_arm?
    study.default_study_arm == self
  end

  def removable?
    subjects.blank?
  end

  SEARCH_FIELDS = [:code]

  def visits_humanize
    vizit_names = visits.collect {|v| v.name}
    vizit_names.join(", ")
  end

  def before_destroy
    if !removable?
      errors.add("subject", "cannot delete subject with crfs assigned")
      return false
    end

    if default_study_arm?
      study.default_study_arm = nil
      study.save!
    end
  end

  private

#  def code_uniq
#    cond = id ? [ "code = ? AND id <> ?", code, id ] : [ "code = ?", code]
#    if (study.study_arms.exists?(cond))
#      errors.add(:code, "has already been taken")
#    end
#  end
end
