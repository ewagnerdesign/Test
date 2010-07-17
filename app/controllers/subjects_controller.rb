class SubjectsController < ApplicationController
  before_filter :get_subject, :only => [:show, :edit, :update, :destroy]

  add_query_filters
  use_hashed_query do |p|
    p[:study_id] = p[:study_id].to_i
    p[:study_arm_id] = p[:study_arm_id].to_i
    p[:subject_id] = p[:subject_id].to_i
    p[:visit_id] = p[:visit_id].to_i
    p[:site_id] = p[:site_id].to_i
    p.delete(:only_with_open_queries) if p[:only_with_open_queries] == "false"
  end

  before_filter :get_current_search_hash, :only => [:index]
  before_filter :get_current_search_condition_hash, :only => [:index]

  before_filter :store_location, :only => [:index]

  # GET /subjects/1
  # GET /subjects/1.xml
  def index
    @studies = Study.all

    @search_condition_params.delete(:study_id_eq) if @current_query[:study_id].zero?
    @search_condition_params.delete(:study_arm_id_eq) if @current_query[:study_arm_id].zero?
    @search_condition_params.delete(:id_eq) if @current_query[:subject_id].zero?
    @search_condition_params.delete(:site_id_eq) if @current_query[:site_id].zero?
    @search_condition_params.delete(:study_arm_visits_id_eq) if @current_query[:visit_id].zero?

    @subjects = Subject.ascend_by_id.search(@search_params.merge(@search_condition_params)).paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @subjects }
      format.json { render :json => @subjects.to_json(:only => [:id, :number]) }
      format.js {
        if params[@template.dom_id_nested(:commit)].blank? && params[:page].blank?
          render :file => 'subjects/index.html.erb'
        else
          render(:update) {|page| page[dom_id_nested(:data_area)].replace :file => "subjects/index" }
        end
      }

    end
  end

  # GET /subjects/1
  # GET /subjects/1.xml
  def show
    respond_to do |format|
      format.xml  { render :xml => @subject }
      format.js   #show.js.rjs
    end
  end

    # GET /subjects/new
  # GET /subjects/new.xml
  def new
    @subject = Subject.new(:consent_datetime => DateTime.now)

    study_id = @current_query[:study_id]
    @subject.study = Study.find_by_id(study_id) if study_id > 0
    @subject.study_arm = @subject.study.try(:default_study_arm)

    respond_to do |format|
      format.xml  { render :xml => @subject }
      format.js
    end
  end

  # POST /subjects
  # POST /subjects.xml
  def create
    @subject = Subject.new(params[:subject])

    respond_to do |format|
      if @subject.save
        flash[:notice] = 'Subject was successfully created.'
        format.html { redirect_to(@subject) }
        format.xml  { render :xml => @subject, :status => :created, :location => @subject }
        format.js   #create.js.rjs
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subject.errors, :status => :unprocessable_entity }
        format.js   #create.js.rjs
      end
    end
  end


  # GET /subjects/1/edit
  def edit
    respond_to do |format|
      format.html # edit.html.erb
      format.js  #edit.js.rjs
    end
  end


  # PUT /subjects/1
  # PUT /subjects/1.xml
  def update
    respond_to do |format|
      if @subject.update_attributes(params[:subject])
        flash[:notice] = 'Subject was successfully updated.'
        format.xml  { head :ok }
        format.js
      else
        format.xml  { render :xml => @subject.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.xml
  def destroy
    respond_to do |format|
      if @subject.destroy
        format.html { redirect_to(@subject) }
        format.js   { render (:update) {|page| page[dom_id_nested(:item, @subject)].remove() } }
      else
        flash[:notice] = 'Subject was not deleted.'
        format.html { redirect_to subjects_path }
        format.js   { render (:update) { |page|  page.alert("Cannot delete subject #{@subject.number}") }}
      end
    end
  end

  protected

  def get_subject
    @subject = Subject.find(params[:id])
  end

end
