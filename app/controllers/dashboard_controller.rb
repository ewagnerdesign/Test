class DashboardController < ApplicationController
  LATEST_ACTIVITIES = 5

  def index
    begin
      @date = Date.parse(params[:date])
    rescue
      @date = Date.today
    end

    @studies = Study.all
    @study_id = params[:study_id].to_i

    start_date = @date.beginning_of_week
    @visits_by_week = {}

    7.times do |day|
      search_hash = {:start_date_eq => start_date}
      search_hash[:study_id_eq] = @study_id if @study_id > 0
      @visits_by_week[start_date] = Visit.search(search_hash).count
      start_date += 1
    end

    # obtain latest records about FormInstances
    activities = Audit.auditable_type_is_any("FormInstance")
    activities = activities.auditable_form_instance_type_subject_study_id_eq(@study_id) if @study_id > 0
    activities = activities.descend_by_id.all(:limit => LATEST_ACTIVITIES)
    @latest_activities = activities

    # obtain latest records about Queries
    activities = Audit.auditable_type_is_any("Query")
    activities = activities.auditable_query_type_form_field_value_form_instance_subject_study_id_eq(@study_id) if @study_id > 0
    activities = activities.descend_by_id.all(:limit => LATEST_ACTIVITIES)
    @latest_activities += activities

    # sort merged arrays and truncate unnecessary records
    @latest_activities = @latest_activities.sort{|a, b| b.id <=> a.id}
    @latest_activities = @latest_activities.values_at(0..(LATEST_ACTIVITIES - 1)) if @latest_activities.length > LATEST_ACTIVITIES

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

end
