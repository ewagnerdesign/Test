class Admin::StudyVisitsController < AdminController
  before_filter :get_parent
  before_filter :get_visit, :only => [:show, :edit, :update, :destroy]

  def index
    set_current_query(@study)
    @visits = @study.visits.ascend_by_number.search(get_current_search(Visit))

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @visits }
      format.js  {
        if params[:force_html]
          render :file => 'admin/study_visits/index.html.erb'
        else
          render(:update) {|page| page[dom_id_nested(:index, @study)].replace :file => "admin/study_visits/index" }
        end
      }
    end
  end

  def show
    set_current_query(@study)

    respond_to do |format|
      format.xml  { render :xml => @visit }
      format.js   #show.js.rjs
    end
  end

  # GET /visits/new
  # GET /visits/new.xml
  def new
    @visit = @study.visits.new

    respond_to do |format|
      format.xml  { render :xml => @visit }
      format.js  
    end
  end

  # GET /visits/1/edit
  def edit
    respond_to do |format|
      format.js  #edit.js.rjs
    end
  end

  # POST /visits
  # POST /visits.xml
  def create
    params[:visit][:prev_visit_id] = nil if params[:relative_visit] == "false"
    @visit = @study.visits.build(params[:visit])

    respond_to do |format|
      if @study.save
        flash[:notice] = 'Visit was successfully created.'
        format.xml  { render :xml => @visit, :status => :created, :location => @visit }
        format.js   #create.js.rjs
      else
        format.xml  { render :xml => @visit.errors, :status => :unprocessable_entity }
        format.js   #create.js.rjs
      end
    end
  end

  # PUT /visits/1
  # PUT /visits/1.xml
  def update
    params[:visit][:prev_visit_id] = nil if params[:relative_visit] == "false"
    respond_to do |format|
      if @visit.update_attributes(params[:visit])
        flash[:notice] = 'Visit was successfully updated.'
        format.xml  { head :ok }
        format.js
      else
        format.xml  { render :xml => @visit.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @visit.destroy

    respond_to do |format|
      format.xml  { head :ok }
      format.js   { render (:update) {|page| page[dom_id_n(:item, @study, @visit)].remove() } } #TODO: Show emptiness message if need 
    end
  end

  protected

  def get_parent
    @study = Study.find(params[:study_id])
    #TODO
    selected_study_arm_id = params[:selected_study_arm_id].to_i
    @selected_study_arm = (@study && selected_study_arm_id > 0 && StudyArm.exists?(selected_study_arm_id)) ? StudyArm.find(selected_study_arm_id) : @study.default_study_arm
  end

  def get_visit
    @visit = Visit.find(params[:id])
  end

end
