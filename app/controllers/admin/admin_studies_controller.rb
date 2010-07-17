class Admin::AdminStudiesController < AdminController

  # GET /contacts
  # GET /contacts.xml
  def index
    set_current_query
    page = params[@template.dom_id_nested(:page)]

    #TODO May be optimized by performance:
    #  - one request to DB server
    #  - ORDER BY and PAGINATE on server side
    # see searchlogic issue definition at http://github.com/binarylogic/searchlogic/issues/#issue/35
    entities_filtered = Study.search(get_current_search(Study, @current_query))
    entities_with_ta_filtered = Study.search(get_current_search(TherapeuticArea, @current_query, "therapeutic_area"))
    @entities = entities_filtered.all | entities_with_ta_filtered.all
    @entities.sort!{|x,y| x.name <=> y.name }
    @entities = @entities.paginate :page => page

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entities }
      format.js  {
        if params[@template.dom_id_nested(:commit)].blank? && page.blank?
          render :file => 'admin/admin_studies/index.html.erb'
        else
          render(:update) {|page| page[:studies_index].replace :file => "admin/admin_studies/index" }
        end
      }
    end
  end


  # GET /studies/1
  # GET /studies/1.xml
  def show
    set_current_query
    @study = Study.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @study }
      format.js   #show.js.rjs
    end
  end

  # GET /studies/new
  # GET /studies/new.xml
  def new
    @study = Study.new

    respond_to do |format|
      format.xml  { render :xml => @study }
      format.js  #new.js.rjs
    end
  end

  # GET /studies/1/edit
  def edit
    @study = Study.find(params[:id])

    respond_to do |format|
      format.js  #edit.js.rjs
    end
  end

  # POST /studies
  # POST /studies.xml
  def create
    @study = Study.new(params[:study])

    respond_to do |format|
      if @study.save
        flash[:notice] = 'Study was successfully created.'
        format.xml  { render :xml => @study, :status => :created, :location => @study }
        format.js   #create.js.rjs
      else
        format.xml  { render :xml => @study.errors, :status => :unprocessable_entity }
        format.js   #create.js.rjs
      end
    end
  end

  # PUT /studies/1
  # PUT /studies/1.xml
  def update
    @study = Study.find(params[:id])

    respond_to do |format|
      if @study.update_attributes(params[:study])
        flash[:notice] = 'Study was successfully updated.'
        format.xml  { head :ok }
        format.js
      else
        format.xml  { render :xml => @study.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /studies/1
  # DELETE /studies/1.xml
  def destroy
    @study = Study.find(params[:id])
    @study.destroy

    respond_to do |format|
      format.xml  { head :ok }
      format.js
    end
  end


end
