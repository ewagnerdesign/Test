class Admin::StudyFormsController < AdminController
  before_filter :get_study
  before_filter :get_study_arm_visit

  # GET /forms/1
  # GET /forms/1.xml
  def index
    @forms = @study_arm_visit.forms

    respond_to do |format|
      format.xml  { render :xml => @forms }
      format.json { render :json => @forms.to_json(:only => [:id, :code]) }
      format.js   { render(:update) {|page| page[dom_id_nested(:index, @study)].replace :file => "admin/study_forms/index" }
      }
    end
  end

  # GET /forms/1
  # GET /forms/1.xml
  def show
    @form = Form.find(params[:id])
    respond_to do |format|
      format.xml  { render :xml => @form }
      format.js   #show.js.rjs
    end
  end

  # GET /forms/new
  # GET /forms/new.xml
  def new
    return if params[:cancel]

    selected_study_id = params[:selected_study_id].to_i
    @forms = (selected_study_id > 0) ?
      Form.study_arm_visits_study_arm_study_id_eq(selected_study_id).all(:group => "forms.id") :
      Form.noncumulative_forms.all
    @forms -= @study_arm_visit.forms
    render(:update) {|page| page[dom_id_nested(:available_forms, @study)].replace_html :partial => "admin/study_forms/form", :collection => @forms} if selected_study_id > 0
  end

  # POST /forms
  # POST /forms.xml
  def create
    forms = Form.find(params[:forms]) if params[:forms]
    @study_arm_visit.forms += forms unless forms.blank?

    #TODO error processing (example: cumulative forms)
    @forms = @study_arm_visit.forms
    render(:update) {|page| page["index-study_#{@study.id}-study_forms"].replace :file => "admin/study_forms/index.html.erb"} #TODO <%= dom_id_nested(:index, @study)
  end

  def destroy
    @study_arm_visit.forms.delete(Form.find(params[:id]))
    @forms = @study_arm_visit.forms
    render(:update) {|page| page["index-study_#{@study.id}-study_forms"].replace :file => "admin/study_forms/index.html.erb"} #TODO <%= dom_id_nested(:index, @study)
  end

  protected

  def get_study
    @study = Study.find(params[:study_id])
  end

  def get_study_arm_visit
    @study_arm_visit = StudyArmVisit.find(params[:study_arm_visit_id])
  end

end
