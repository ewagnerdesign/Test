class Query < ActiveRecord::Base
  belongs_to :user
  belongs_to :form_field_value
  belongs_to :closed_by, :class_name => "User"

  has_many :comments, :class_name => "QueryComment", :order => :id, :dependent => :destroy

  acts_as_audited

  validates_presence_of :user_id, :form_field_value_id

  named_scope :all_cond
  named_scope :opened, :conditions => {:closed => false}
  named_scope :closed, :conditions => {:closed => true}

  SEARCH_FIELDS = []
  SEARCH_CONDITIONS = {
    :study_id => :form_field_value_form_instance_subject_study_id_eq,
    :site_id => :form_field_value_form_instance_subject_site_id_eq,
    :subject_id => :form_field_value_form_instance_subject_id_eq
  }

  def latest_activity_type
    "QUERY"
  end

  def latest_activity_name
    comment
  end

  def comments_with_changes
    all_comments = comments.clone()

    audits = Audit.auditable_type_is("FormFieldValue").auditable_id_is(form_field_value.id).created_at_lte((closed?) ? updated_at : Time.now).created_at_gte(created_at).all
    audits.each do |a|
      change_text = ""
      a.attributes["changes"].each do |f,v|
        change_text << "\n" unless change_text.empty?
        change_text << f.humanize << ": " << v.first.to_s << " -> " << v.last.to_s
      end
      all_comments << QueryComment.new(:user => User.find(a.user_id), :comment => change_text,
                                       :query_type => QueryComment::TYPE_CHANGED, :created_at => a.created_at)
    end
    all_comments.sort_by { |x| x.created_at }
  end

  # queries quired before this query on the same form_field_value
  def previous_queries
    self.form_field_value.queries.id_lt(self.id)
  end

  # finds last query for the related form_field_value
  def last_for_value
    self.form_field_value.queries.last
  end

  def need_reply?
    comments.count.zero? || comments.last.query?
  end

  def close(user)
    raise "Already closed" if self.closed?

    self.closed = true
    self.closed_by = user
    save!
  end

  def status
    if self.closed?
      "closed"
    elsif self.need_reply?
      "unreplied"
    else
      "replied"
    end
  end

  def Query.find_by_obj(obj)
    return form_field_value_form_instance_subject_id_eq(obj.id).all if obj.is_a?(Subject)
    return form_field_value_form_instance_visit_id_eq(obj.id).all if obj.is_a?(Visit)
    return form_field_value_form_instance_id_is(obj.id).all if obj.is_a?(FormInstance)
    raise "Unknown object"
  end

  protected

  def validate_on_create
    errors.add("form_instance", "is not submitted") unless form_field_value.form_instance.submitted?
    last_query = form_field_value.queries.last
    errors.add("previous query", "is not accepted") unless last_query.nil? || last_query.closed?
  end

end


