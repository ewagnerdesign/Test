class Admin::CdashQuestionsController < AdminController
  before_filter :get_parent
  before_filter :get_cdash_question, :only => [:show, :edit, :update, :destroy]

  # GET /cdash_questions
  # GET /cdash_questions.xml
  def index
    @cdash_questions = 
      if request.format == :json
        @domain.cdash_questions
      else
        @domain.cdash_questions.ascend_by_id.search(get_current_search(CdashQuestion, @current_query[:query])).paginate(:page => params[@template.dom_id_nested(:page, @domain)])
      end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cdash_questions }
      format.js  {
        if params[@template.dom_id_nested(:commit, @domain)].blank? && params[@template.dom_id_nested(:page, @domain)].blank?
          render :file => 'admin/cdash_questions/index.html.erb'
        else
          render (:update) {|page| page[dom_id_nested(:index, @domain)].replace :file => "admin/cdash_questions/index" }
        end
      }
      format.json {
         render :json => @cdash_questions.to_json(
                 :include => {
                    :sdtm_category=> {
                       :only => [ :id,  :code ]
                    }
                 }
         )
      }
    end
  end

  # GET /cdash_questions/1.xml
  # GET /cdash_questions/1
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cdash_question }
      format.js   #show.js.rjs
      format.json { render :json => @cdash_question.to_json}
    end
  end

  # GET /cdash_questions/new
  # GET /cdash_questions/new.xml
  def new
    @cdash_question = @domain.cdash_questions.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cdash_question }
      format.js  #new.js.rjs
    end
  end

  # GET /cdash_questions/1/edit
  def edit
    respond_to do |format|
      format.html # edit.html.erb
      format.js  #edit.js.rjs
    end
  end

  # POST /cdash_questions
  # POST /cdash_questions.xml
  def create
    @cdash_question = @domain.cdash_questions.new(params[:cdash_question])
    respond_to do |format|
      if @cdash_question.save
        flash[:notice] = 'CdashQuestion was successfully created.'
        format.html { redirect_to(@cdash_question) }
        format.xml  { render :xml => @cdash_question, :status => :created, :location => @cdash_question }
        format.js   #create.js.rjs
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cdash_question.errors, :status => :unprocessable_entity }
        format.js   #create.js.rjs
      end
    end
  end

  # PUT /cdash_questions/1
  # PUT /cdash_questions/1.xml
  def update
    respond_to do |format|
      if @cdash_question.update_attributes(params[:cdash_question])
        flash[:notice] = 'CdashQuestion was successfully updated.'
        format.html { redirect_to(@cdash_question) }
        format.xml  { head :ok }
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cdash_question.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /cdash_questions/1
  # DELETE /cdash_questions/1.xml
  def destroy
    @cdash_question.destroy

    respond_to do |format|
      format.html { redirect_to(@cdash_question) }
      format.xml  { head :ok }
      format.js   { render (:update) {|page| page[dom_id(@cdash_question)].remove() } }
    end
  end

  protected

  def get_parent
    @domain = Domain.find(params[:domain_id])
    
    get_current_query(nil, "domains")
    # clear @current_query[:query] if user has unchecked the "Search children" checkbox
    # @current_query should be filled to this time
    @current_query = @current_query[:inc_children] ? @current_query[:query] : ""
  end
  
  def get_cdash_question
    @cdash_question = CdashQuestion.find(params[:id])
  end

end
