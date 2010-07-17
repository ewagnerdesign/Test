class EcrfsController < ApplicationController
  add_query_filters
  use_hashed_query do |p|
    p[:study_id] = p[:study_id].to_i
    p[:study_arm_id] = p[:study_arm_id].to_i
    p[:subject_id] = p[:subject_id].to_i
    p[:visit_id] = p[:visit_id].to_i
    p[:site_id] = p[:site_id].to_i
    p[:show] = "all_cond" unless p[:show]
  end

  with_options :only => [:index] do
    before_filter { |c| c.get_current_search_hash(:model => FormInstance) }
    before_filter { |c| c.get_current_search_condition_hash(:model => FormInstance) }
  end

  before_filter :store_location, :only => [:index]

  def index
    @crf_list_forms = Form.crf_list_search(@current_query.merge({:page => params[:page]}))
    @crf_list = Form.unpack_crf_list_search_results(@crf_list_forms, @current_query)

    study = Study.find_by_id(@current_query[:study_id])
    @studies = Study.all

    if study.nil?
      @study_arms = []
      @subjects = []
      @visits = []
    else
      @study_arms = study.study_arms
      @subjects = study.subjects
      @visits = study.visits
    end

    respond_to do |format|
      format.html
      format.js  { render(:update) {|page| page[dom_id_nested(:data_area)].replace :file => "ecrfs/index" } }
    end
  end

  def new
    version = Form.find(params[:form_id]).form_versions.last
    @form_instance = version.form_instances.build(:subject_id => params[:subject_id], :visit_id => params[:visit_id], :actual_date_time => DateTime.now)
    # :site_id => current_user.site.id
    @form = Former.new(@form_instance)
    @form_data = ActiveSupport::JSON.decode(@form_instance.form_version.metadata)
  end

  def create
    @form_instance = FormInstance.new(params[:form_instance])
    form_params = params[:form] || {}
    @former = Former.new(@form_instance)

    Audit.group_audit(@form_instance, false) do
      @former.create(form_params.key?(:base)? form_params[:base] : {})

      if params[:submit_form] == "1"
        @former.instance.submit(current_user)
      end
    end

    flash[:notice] = "Form was succesfully created"
    redirect_back_or_default({:action => 'index'}, :html)
  end

  def update
    @form_instance = FormInstance.find(params[:id], {:include => :form_field_values})
    @form = Former.new(@form_instance)
    form_params = params[:form] || {}

    Audit.group_audit(@form.instance) do
      @form.update(form_params.key?(:base)? form_params[:base] : {})
      #logger.info @form.instance.form_field_values.inspect
      #@form.instance.save

      #update actual date time
      time_fields = params[:form_instance].inject({}) { |res, k| res.merge!({k.first => k.second}) if k.first =~ /actual_date_time\(/; res }
      @form.instance.update_attributes!(time_fields)

      #updated submitted tag
      if params[:submit_form] == "1"
        @form.instance.submit(current_user)
      end
    end

    flash[:notice] = "Form was succesfully updated"
    redirect_back_or_default({:action => 'index'}, :html)
  end

  def show
    @form_instance = FormInstance.find(params[:id], {:include => :form_field_values})
    @form = Former.new(@form_instance)

    @form_data = ActiveSupport::JSON.decode(@form_instance.form_version.metadata)
  end
end
