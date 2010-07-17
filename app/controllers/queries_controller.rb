class QueriesController < ApplicationController
  add_query_filters
  use_hashed_query do |p|
    p[:study_id] = p[:study_id].to_i
    p[:subject_id] = p[:subject_id].to_i
    p[:site_id] = p[:site_id].to_i
    p[:show] = "all_cond" unless p[:show]
  end

  before_filter :get_current_search_condition_hash, :only => [:index]
  before_filter :store_location, :only => [:index]

  # GET /queries/1
  # GET /queries/1.xml
  def index
    @studies = Study.all
    @search_condition_params.delete(:form_field_value_form_instance_subject_study_id_eq) if @current_query[:study_id].zero?
    @search_condition_params.delete(:form_field_value_form_instance_subject_id_eq) if @current_query[:subject_id].zero?
    @search_condition_params.delete(:form_field_value_form_instance_subject_site_id_eq) if @current_query[:site_id].zero?
    @queries = Query.ascend_by_id.search(@search_condition_params.merge(@current_query[:show] => true)).paginate(:page => params[:page])
    @subjects = Subject.find_all_by_study_id(@current_query[:study_id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @queries }
      format.js {
        if params[@template.dom_id_nested(:commit)].blank? && params[:page].blank?
          render :file => 'queries/index.html.erb'
        else
          render(:update) {|page| page[dom_id_nested(:data_area)].replace :file => "queries/index" }
        end
      }

    end
  end

  # GET /queries
  # queries list for form_field_value queries popup
  def list
    form_field_value = FormFieldValue.find(params[:form_field_value_id])
    @current_query_id = params[:query_id].to_i
    @last_query = form_field_value.queries.last
    @previous_queries = @last_query.previous_queries
    @query_comment = QueryComment.new
    @reload_queries = params[:reload_queries] == "true"

    respond_to do |format|
      format.html { render :file => 'queries/list.html.erb' }
      format.js { render :file => 'queries/list.html.erb' }
    end
  end

  # GET /queries/1
  def show
    @query = Query.find(params[:id])

    respond_to do |format|
      format.html { render :file => 'queries/show.html.erb' }
      format.js { render :file => 'queries/show.html.erb' }
    end
  end

  # PUT /queries/1
  def close
    @query = Query.find(params[:id])
    @query.close(current_user)

    respond_to do |format|
      flash[:notice] = 'Query was closed.'
      format.js { render :file => 'queries/update_status.js.rjs' }
    end
  end

  # GET /queries/new
  def new
    @query = Query.new(:user => current_user, :form_field_value => FormFieldValue.find(params[:form_field_value_id]))
    @reload_queries = params[:reload_queries] == "true"
    respond_to do |format|
      format.html { render :partial => "new"}
    end
  end

  # POST /queries
  # POST /queries.xml
  def create
    @reload_queries = params[:reload_queries] == "true"
    @query = Query.new(params[:query])
    @query.user = current_user

    respond_to do |format|
      if @query.save
        flash[:notice] = 'Query was successfully created.'
        format.html { redirect_to :action => "index" }
        format.js
      else
        format.html { render :action => "new" }
      end
    end
  end
end
