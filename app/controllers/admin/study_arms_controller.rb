class Admin::StudyArmsController < AdminController
  before_filter :get_parent
  before_filter :get_study_arm, :only => [:update, :destroy, :rename]

  # GET /study_arms
  # GET /study_arms.xml
  def index
    @study_arms = @study.study_arms.ascend_by_id

    respond_to do |format|
      format.json { render :json => @study_arms.all.to_json(:only => [:id, :code]) }
    end
  end


  def create
    @study_arm = @study.study_arms.build(:code => params[:name])
    result = @study_arm.save
    @study.study_arms.delete(@study_arm) unless result
  end

  def update
    if params[:visits]
      # to delete properly old visits from study_arm, we need to destroy
      # study_arm_visits to destroy also form_study_arm_visit
      new_visits = Visit.find(params[:visits])
      visits_destroy = @study_arm.visits - new_visits
      @study_arm.study_arm_visits.visit_id_eq(visits_destroy).destroy_all
      @study_arm.visits = new_visits
    end

    if @study_arm.update_attributes(params[:study_arm])
      flash[:notice] = 'StudyArm was successfully updated.'
    end
    respond_to do |format|
      format.js { redirect_to admin_study_visits_path(@study, :format => :js, :selected_study_arm_id => @study_arm) }
    end
  end

  def rename
    @study_arm.code = params[:name]
    respond_to do |format|
      if @study_arm.save
        flash[:notice] = 'StudyArm was successfully updated.'
        format.xml  { head :ok }
        format.js
      else
        format.xml  { render :xml => @study_arm.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @study_arm.destroy

    respond_to do |format|
      format.xml  { head :ok }
      format.js   { render (:update) {|page| page[dom_id_n(:item, @study, @study_arm)].remove() } } #TODO: Show emptiness message if need;
    end
  end

  protected

  def get_parent
    @study = Study.find(params[:study_id])
  end

  def get_study_arm
    @study_arm = StudyArm.find(params[:id])
    #TODO
    selected_study_arm_id = params[:selected_study_arm_id].to_i
    @selected_study_arm = (@study && selected_study_arm_id > 0 && StudyArm.exists?(selected_study_arm_id)) ? StudyArm.find(selected_study_arm_id) : @study.default_study_arm
  end
end
