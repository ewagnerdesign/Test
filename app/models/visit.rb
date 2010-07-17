class Visit < ActiveRecord::Base
  before_validation :check_is_relative

  has_many :next_visits, :class_name => "Visit", :foreign_key => "prev_visit_id"
  belongs_to :prev_visit, :class_name => "Visit"

  belongs_to :study

  has_many :form_instances

  has_many :study_arm_visits, :dependent => :destroy
  has_many :study_arms, :through => :study_arm_visits

  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_uniqueness_of :name, :scope => :study_id, :message => "has already been taken"

  validates_presence_of :number
  validates_length_of :number, :maximum => 45
  validates_uniqueness_of :number, :scope => :study_id, :message => "has already been taken"

  validates_length_of :status, :maximum => 45, :allow_nil => true

  validates_presence_of :start_date, :if => Proc.new { |visit| visit.prev_visit.nil? }
  #validates_presence_of :end_date, :if => Proc.new { |visit| visit.prev_visit.nil? }
  validates_each :start_date do |visit, attr, value|
    if visit.prev_visit.nil?
      visit.errors.add :end_date, 'should be greater than Start date.' unless visit.start_date.nil? || visit.end_date.nil? || visit.start_date <= visit.end_date
    else
      v = visit
      while !v.prev_visit.nil?
        v = v.prev_visit
        if v.eql?(visit)
          visit.errors.add :prev_visit, 'Self-reference is not allowed.'
          break
        end
      end
    end
    visit.errors.add :this, 'visit or it''s descendants already in use' unless visit.editable?
  end


  validates_presence_of :prev_visit_start_offset_day, :if => Proc.new { |visit| !visit.prev_visit.nil? }
  validates_numericality_of :prev_visit_start_offset_day, :integer_only => true, :greater_than_or_equal_to => 0, :if => Proc.new { |visit| !visit.prev_visit.nil? }
  validates_presence_of :prev_visit_end_offset_day, :if => Proc.new { |visit| !visit.prev_visit.nil? }
  validates_numericality_of :prev_visit_end_offset_day, :integer_only => true, :greater_than_or_equal_to => 0, :if => Proc.new { |visit| !visit.prev_visit.nil? }
  validates_each :prev_visit_start_offset_day do |visit, attr, value|
    visit.errors.add :prev_visit_end_offset_day, 'End offset should be greater than Start offset.' unless visit.prev_visit_start_offset_day.nil? || visit.prev_visit_end_offset_day.nil? || visit.prev_visit_start_offset_day <= visit.prev_visit_end_offset_day
  end

  def editable?
    form_instances.empty? && next_visits.all.all?{|nv| nv.editable?}
  end

  # similar to next_visits, but recursive includes all next_visits from next_visits
  def descendant_visits
    next_visits + next_visits.all.collect {|nv| nv.descendant_visits}.flatten
  end

  named_scope :all_days
  named_scope :today, lambda { { :conditions => { :start_date => Date.today }}}
  named_scope :overdue, lambda { { :conditions => ['start_date < ?', Date.today]}}
  named_scope :today_overdue, lambda { { :conditions => ['start_date <= ?', Date.today]}}
  named_scope :by_date, lambda { |date|
    begin
      date = Date.parse(date.to_s)
    rescue
      date = "nil"
    end
    { :conditions => { :start_date => date }}}


  SEARCH_FIELDS = [:number, :name, :notes]
  SEARCH_CONDITIONS = {
    :study_id => :study_id_eq,
    :subject_id => :study_arms_subjects_id_eq,
    :study_arm_id => :study_arms_id_eq,
    :site_id => :study_arms_subjects_site_id_eq
    }

  protected

  def check_is_relative
    if prev_visit.nil?
      self.prev_visit_start_offset_day = nil
      self.prev_visit_end_offset_day = nil
    else
      self.start_date = nil
      self.end_date = nil
    end
  end

end
