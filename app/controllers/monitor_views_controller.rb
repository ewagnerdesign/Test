class MonitorViewsController < ApplicationController
  before_filter :get_monitor_view, :only => [:show, :edit, :update, :edit_fields, :update_fields, :destroy, :monitored]

  add_query_filters
  use_hashed_query do |p|
    p[:study_id] = p[:study_id].to_i
    p[:form_id] = p[:form_id].to_i
    p[:study_arm_id] = p[:study_arm_id].to_i
    p[:visit_id] = p[:visit_id].to_i
    p[:site_id] = p[:site_id].to_i
    p[:show] = "all_cond" unless p[:show]
  end

  before_filter :get_current_search_condition_hash, :only => [:index]
  before_filter :store_location, :only => [:show]

  # GET /monitor_views
  def index
    study = Study.find_by_id(@current_query[:study_id])
    @studies = Study.all
    @search_condition_params.delete(:study_id_eq) if @current_query[:study_id].zero?
    @search_condition_params.delete(:form_id_eq) if @current_query[:form_id].zero?
    @search_condition_params.delete(:form_visits_study_arms_id_eq) if @current_query[:study_arm_id].zero?
    @search_condition_params.delete(:form_visits_id_eq) if @current_query[:visit_id].zero?
    @search_condition_params.delete(:form_visits_study_arms_subjects_site_id_eq) if @current_query[:site_id].zero?
    @monitor_views = MonitorView.ascend_by_id.search(@search_condition_params.merge(@current_query[:show] => true)).uniq.paginate(:page => params[:page]) # 'uniq' has been used to avoid troubles with searchlogic
    @visits = study.try(:visits) || []
    @study_arms = study.try(:study_arms) || []
    @forms = @visits.nil? ? [] : Form.form_study_arm_visits_study_arm_visit_visit_id_eq(@visits).all(:group => 'id')

    respond_to do |format|
      format.html
      format.xml  { render :xml => @monitor_views }
      format.js   { render(:update) {|page| page[dom_id_n(:data_area)].replace :file => "monitor_views/index" } }
    end
  end

  # GET /monitor_views/new
  def new
    @monitor_view = MonitorView.new

    study_id = @current_query[:study_id]
    @monitor_view.study = Study.find_by_id(study_id) if study_id > 0
    form_id = @current_query[:form_id]
    @monitor_view.form = Form.find_by_id(form_id) if form_id > 0

    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.html # edit.html.erb
      format.js  #edit.js.rjs
    end
  end

  def create
    @monitor_view = MonitorView.new(params[:monitor_view])

    respond_to do |format|
      if @monitor_view.save
        flash[:notice] = 'View was successfully created.'
        format.html { redirect_to(@monitor_view) }
        format.xml  { render :xml => @monitor_view, :status => :created, :location => @monitor_view }
        format.js   #create.js.rjs
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @monitor_view.errors, :status => :unprocessable_entity }
        format.js   #create.js.rjs
      end
    end
  end

  def show
    search_params = params[:search] || {}
    search_params.merge!({:study_id => @monitor_view.study.id, :form_id => @monitor_view.form.id})

    if params["commit-monitor_views"] != "Go"
      search_params.delete_if { |k,v| ![:study_id, :form_id].include?(k.to_sym) }
      @subject_id = @visit_id = 0
      @from_date = @to_date = nil
    else
      @subject_id = search_params[:subject_id].to_i
      @visit_id   = search_params[:visit_id].to_i
      @date_from  = search_params[:date_from]
      @date_to    = search_params[:date_to]
    end

    @ecrfs = FormInstance.monitor_view_find(search_params).paginate(:page => params[:page])

    respond_to do |format|
      format.html # edit.html.erb
      format.js { render(:update) {|page| page[dom_id_n(:main)].replace_html :file => "monitor_views/show" } }
    end
  end

  def update
    params[:monitor_view].delete_if { |k,v| ![:name].include?(k.to_sym) }
    respond_to do |format|
      if @monitor_view.update_attributes(params[:monitor_view])
        flash[:notice] = 'View was successfully updated.'
        format.html { redirect_to(@monitor_view) }
        format.xml  { head :ok }
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @monitor_view.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @monitor_view.destroy

    respond_to do |format|
      format.xml  { head :ok }
      format.js   { render (:update) {|page| page[dom_id_n(:item, @monitor_view)].remove() } } #TODO: Show emptiness message if need
    end
  end

  def edit_fields
  end

  def update_fields
    field_ids = params[:field_ids].kind_of?(Array) ? params[:field_ids].map(&:to_i) : []
    @monitor_view.form_fields = field_ids.map {|field_id| @monitor_view.form.last_form_field(field_id)}

    respond_to do |format|
      if @monitor_view.save
        flash[:notice] = 'MonitorView was successfully updated.'
        format.xml  { render :xml => @monitor_view, :status => :created, :location => @monitor_view }
        format.js { redirect_to :action => "show", :id => @monitor_view.id, :format => "js" }
      else
        format.xml  { render :xml => @monitor_view.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  def monitored
    #TODO move to transaction

    form_instance_monitored_ids = params[:form_instances_monitored].kind_of?(Array) ? params[:form_instances_monitored].map(&:to_i) : []
    form_instance_in_list_ids = params[:form_instances_in_list].kind_of?(Array) ? params[:form_instances_in_list].map(&:to_i) : []

    @ffvs = FormFieldValue.form_instance_id_eq(form_instance_in_list_ids).form_field_id_eq(@monitor_view.form_fields.map{|ff| ff.id})
    @ffvs.each do |ffv|
      ffv.monitored = form_instance_monitored_ids.include?(ffv.form_instance_id)
      ffv.save
    end
  end

  protected

  def get_monitor_view
    @monitor_view = MonitorView.find(params[:id])
  end

end
