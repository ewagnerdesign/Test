class Admin::SdtmAnswersController < AdminController
  before_filter :get_parent
  before_filter :check_sdtm_category_extensible, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :get_sdtm_answer, :only => [:show, :edit, :update, :destroy]
  before_filter :get_sdtm_answer_editable, :only => [:edit, :update, :destroy]

  # GET /sdtm_answers
  # GET /sdtm_answers.xml
  def index
    @sdtm_answers = @sdtm_category.sdtm_answers.ascend_by_id.search(get_current_search(SdtmAnswer, @current_query[:query])).paginate(:page => params[@template.dom_id_nested(:page, @sdtm_category)])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sdtm_answers }
      format.js  {
        if params[@template.dom_id_nested(:commit, @sdtm_category)].blank? && params[@template.dom_id_nested(:page, @sdtm_category)].blank?
          render :file => 'admin/sdtm_answers/index.html.erb'
        else
          render (:update) {|page| page[dom_id_nested(:index, @sdtm_category)].replace :file => "admin/sdtm_answers/index" }
        end
      }
  	  format.json { render :json => @sdtm_category.sdtm_answers.to_json(:only =>[:id, :nci_preferred_term]) } #TODO DB access optimization 
    end
  end

  # GET /sdtm_answers/1.xml
  # GET /sdtm_answers/1
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sdtm_answer }
      format.js   #show.js.rjs
    end
  end

  # GET /sdtm_answers/new
  # GET /sdtm_answers/new.xml
  def new
    @sdtm_answer = @sdtm_category.sdtm_answers.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sdtm_answer }
      format.js  #new.js.rjs
    end
  end

  # GET /sdtm_answers/1/edit
  def edit
    respond_to do |format|
      format.html # edit.html.erb
      format.js  #edit.js.rjs
    end
  end

  # POST /sdtm_answers
  # POST /sdtm_answers.xml
  def create
    @sdtm_answer = @sdtm_category.sdtm_answers.new(params[:sdtm_answer])
    @sdtm_answer.read_only = false
    respond_to do |format|
      if @sdtm_answer.save
        flash[:notice] = 'SdtmAnswer was successfully created.'
        format.html { redirect_to(@sdtm_answer) }
        format.xml  { render :xml => @sdtm_answer, :status => :created, :location => @sdtm_answer }
        format.js   #create.js.rjs
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sdtm_answer.errors, :status => :unprocessable_entity }
        format.js   #create.js.rjs
      end
    end
  end

  # PUT /sdtm_answers/1
  # PUT /sdtm_answers/1.xml
  def update
    respond_to do |format|
      if @sdtm_answer.update_attributes(params[:sdtm_answer])
        flash[:notice] = 'SdtmAnswer was successfully updated.'
        format.html { redirect_to(@sdtm_answer) }
        format.xml  { head :ok }
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sdtm_answer.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /sdtm_answers/1
  # DELETE /sdtm_answers/1.xml
  def destroy
    @sdtm_answer.destroy

    respond_to do |format|
      format.html { redirect_to(@sdtm_answer) }
      format.xml  { head :ok }
      format.js   { render (:update) {|page| page[dom_id(@sdtm_answer)].remove() } }
    end
  end

  protected

  def get_parent
    @sdtm_category = SdtmCategory.find(params[:sdtm_category_id])
    
    get_current_query(nil, "sdtm_categories")
    # clear @current_query[:query] if user has unchecked the "Search children" checkbox
    # @current_query should be filled to this time
    @current_query = @current_query[:inc_children] ? @current_query[:query] : ""
  end
  
  def check_sdtm_category_extensible
    if !@sdtm_category.extensible
      raise "Non-extensible sdtm_category"
    end
  end 

  def get_sdtm_answer
    @sdtm_answer = SdtmAnswer.find(params[:id])
  end

  def get_sdtm_answer_editable
    if @sdtm_answer.read_only
      raise "Readonly sdtm_answer"
    end
  end

end
