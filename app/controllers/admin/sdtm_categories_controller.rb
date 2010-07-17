class Admin::SdtmCategoriesController < AdminController

  before_filter :set_current_query
  before_filter :get_sdtm_category, :only => [:show, :edit, :update, :destroy]
  before_filter :get_sdtm_category_editable, :only => [:edit, :update, :destroy]
 
  # GET /sdtm_categories
  # GET /sdtm_categories.xml
  def index
    if params[:format] == 'json'
      @sdtm_categories = SdtmCategory.all
    else
      check_current_query_parent

      if @current_query[:inc_children]
        #TODO May be optimized by performance:
        #  - one request to DB server
        #  - ORDER BY and PAGINATE on server side
        # see searchlogic issue definition at http://github.com/binarylogic/searchlogic/issues/#issue/35
        sdtm_categories_filtered = SdtmCategory.ascend_by_id.search(get_current_search(SdtmCategory, @current_query[:query]))
        sdtm_categories_with_anws_filtered = SdtmCategory.ascend_by_id.search(get_current_search(SdtmAnswer, @current_query[:query], "sdtm_answers"))
        @sdtm_categories = sdtm_categories_filtered.all + sdtm_categories_with_anws_filtered.all
        @sdtm_categories = @sdtm_categories.uniq
        @sdtm_categories.sort!{|x,y| x.name <=> y.name }
        @sdtm_categories = @sdtm_categories.paginate :page => (params[@template.dom_id_nested(:page)] ? params[@template.dom_id_nested(:page)] : 1)
      else
        @sdtm_categories = SdtmCategory.ascend_by_name.search(get_current_search(SdtmCategory, @current_query[:query])).paginate(:page => params[@template.dom_id_nested(:page)])
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sdtm_categories }
      format.json { render :json => @sdtm_categories.to_json(:only => [:id, :code, :name, :definition]) } 
      format.js  {
        if params[@template.dom_id_nested(:commit)].blank? && params[@template.dom_id_nested(:page)].blank?
          render :file => 'admin/sdtm_categories/index.html.erb'
        else
          render (:update) {|page| page[dom_id_nested(:index)].replace :file => "admin/sdtm_categories/index" }
        end
      }
    end
  end

  # GET /sdtm_categories/1
  # GET /sdtm_categories/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sdtm_category }
      format.js   #show.js.rjs
    end
  end

  # GET /sdtm_categories/new
  # GET /sdtm_categories/new.xml
  def new
    @sdtm_category = SdtmCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sdtm_category }
      format.js  #new.js.rjs
    end
  end
                                                                                        
  # GET /sdtm_categories/1/edit
  def edit
    respond_to do |format|
      format.html # edit.html.erb
      format.js  #edit.js.rjs
    end
  end

  # POST /sdtm_categories
  # POST /sdtm_categories.xml
  def create
    @sdtm_category = SdtmCategory.new(params[:sdtm_category]) 
    @sdtm_category.extensible = true
    @sdtm_category.read_only = false
    
    respond_to do |format|
      if @sdtm_category.save
        flash[:notice] = 'SdtmCategory was successfully created.'
        format.html { redirect_to(@sdtm_category) }
        format.xml  { render :xml => @sdtm_category, :status => :created, :location => @sdtm_category }
        format.js   #create.js.rjs
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sdtm_category.errors, :status => :unprocessable_entity }
        format.js   #create.js.rjs
      end
    end
  end

  # PUT /sdtm_categories/1
  # PUT /sdtm_categories/1.xml
  def update
    respond_to do |format|
      if @sdtm_category.update_attributes(params[:sdtm_category])
        flash[:notice] = 'SdtmCategory was successfully updated.'
        format.html { redirect_to(@sdtm_category) }
        format.xml  { head :ok }
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sdtm_category.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /sdtm_categories/1
  # DELETE /sdtm_categories/1.xml
  def destroy
    @sdtm_category.destroy

    respond_to do |format|
      format.html { redirect_to(@sdtm_category) }
      format.xml  { head :ok }
      format.js   { render (:update) {|page| page[dom_id(@sdtm_category)].remove() } }
    end
  end

  protected

  def get_sdtm_category
    @sdtm_category = SdtmCategory.find(params[:id])
  end

  def get_sdtm_category_editable
    if @sdtm_category.read_only
      raise "Readonly sdtm_category"
    end
  end  
end
