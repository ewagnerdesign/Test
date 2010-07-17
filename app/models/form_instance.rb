class FormInstance < ActiveRecord::Base
  has_many :form_field_values, :autosave => true, :dependent => :destroy
  belongs_to :form_version
  belongs_to :subject
  belongs_to :visit
  belongs_to :submitted_by, :class_name => "User"

  validates_presence_of :form_version_id, :subject_id

  acts_as_audited

  named_scope :by_date_range, lambda { |from, to|
    from_s = to_s = nil
    begin
      from = Date.parse(from.to_s)
      from_s = "date(actual_date_time) >= ?"
    rescue
      from = nil
    end

    begin
      to = Date.parse(to.to_s)
      to_s = "date(actual_date_time) <= ?"
    rescue
      to = nil
    end

    { :conditions => [[from_s, to_s].compact.join(" AND "), from, to].compact }}

  SEARCH_FIELDS = []
  SEARCH_CONDITIONS = {:subject_id => :subject_id_eq, :visit_id => :visit_id_eq}

  def submit(user)
    self.submitted = true
    self.submitted_by = user
    self.submitted_at = Time.now
    save!
  end

  def self.monitor_view_find(search)
    search_params = { :form_version_form_id_eq => search[:form_id] }
    search_params.merge!({ :visit_id_eq => search[:visit_id] }) unless search[:visit_id].blank?
    if search[:subject_id].blank?
      search_params.merge!({:subject_study_id_eq => search[:study_id]})
    else
      search_params.merge!({:subject_id_eq => search[:subject_id]})
    end

    FormInstance.by_date_range(search[:date_from], search[:date_to]).search(search_params)
  end

  def latest_activity_type
    "CRF"
  end

  def latest_activity_name
    "Form: #{name} Subject: #{subject.number}"
  end

  def actual_date_time_fake=(value)
  end

  def values
    form_field_values.inject({}) do |values, ffv|
      values["#{ffv.form_field.label}"] = ffv.value
      values
    end
  end

  def name(show_version = true)
    name = form_version.form.name
    name += " - #{form_version.name}" if show_version
  end

  private

  # override acts_as_audited to include fields changes
  def audited_changes
    ch = changed_attributes.except(*non_audited_columns).inject({}) do |changes,(attr, old_value)|
      changes[attr] = [old_value, self[attr]]
      changes
    end
    ch.merge(get_fields_changes)
  end

  def audited_attributes
    attributes.except(*non_audited_columns).merge(get_fields_changes)
  end

  def audited_attributes_destroy
    attributes.except(*non_audited_columns).
      merge(values.inject({}){|r,(k,v)| r["##{k}"] = v; r}).
      inject({}) {|attrs, (k,v)| attrs.merge!({k=>[v, nil]})}
  end


  # find form_field_values changes "#field_label" => [old, new]
  def get_fields_changes
    form_field_values.inject({}) do |nested_changes, ffv|
      nested_changes["##{ffv.form_field.label}"] = ffv.value_change if ffv.value_changed?
      nested_changes
    end
  end

end
