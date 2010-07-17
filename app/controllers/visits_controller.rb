class VisitsController < ApplicationController
  add_query_filters
  use_hashed_query do |p|
    p[:study_id] = p[:study_id].to_i
    p[:study_arm_id] = p[:study_arm_id].to_i
    p[:subject_id] = p[:subject_id].to_i
    p[:planned_date] = "N/A" if p[:planned_date].try(:"empty?")
    p[:site_id] = p[:site_id].to_i
    p[:show] = "all_days" unless p[:show]
  end

  before_filter :get_current_search_condition_hash, :only => [:index]

  # GET /visits/1
  # GET /visits/1.xml
  def index
    @studies = Study.all

    @search_condition_params.delete(:study_id_eq) if @current_query[:study_id].zero?
    @search_condition_params.delete(:study_arms_subjects_id_eq) if @current_query[:subject_id].zero?
    @search_condition_params.delete(:study_arms_id_eq) if @current_query[:study_arm_id].zero?
    @search_condition_params.delete(:study_arms_subjects_site_id_eq) if @current_query[:site_id].zero?
    # TODO named_scope call security
    visits = Visit.ascend_by_id.search(@search_condition_params.merge(@current_query[:show] => @current_query[:planned_date] || true))
    @subjects = Subject.find_all_by_study_id(@current_query[:study_id])

    respond_to do |format|
      format.html { @visits = visits.paginate(:page => params[:page])}
      format.xml  { render :xml => visits }
      format.json { 
        @visits = (@current_query[:study_id].zero?) ? [] : visits.all
        render :json => @visits
      }
      format.js {
        @visits = visits.paginate(:page => params[:page])
        if params[@template.dom_id_nested(:commit)].blank? && params[:page].blank?
          render :file => 'visits/index.html.erb'
        else
          render(:update) {|page| page[dom_id_nested(:data_area)].replace :file => "visits/index" }
        end
      }

    end
  end
end
