require 'tzinfo'

class Admin::AdminSitesController < AdminController
  # GET /sites
  # GET /sites.xml
  def index
    set_current_query
    page = params[@template.dom_id_nested(:page)]
    @entities = Site.descend_by_created_at.search(get_current_search(Site)).paginate(:page => page)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entities }
      format.js  {
        if params[@template.dom_id_nested(:commit)].blank? && page.blank?
          render :file => 'admin/admin_sites/index.html.erb'
        else
          render(:update) {|page| page[:sites_index].replace :file => "admin/admin_sites/index" }
        end
      }
    end

  end

  # GET /sites/1
  # GET /sites/1.xml
  def show
    set_current_query
    @site = Site.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @site }
      format.js   #show.js.rjs
    end
  end

  # GET /sites/new
  # GET /sites/new.xml
  def new
    @site = Site.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @site }
      format.js  #new.js.rjs #{render :file => 'sites/new.html.erb'}
    end
  end

  # GET /sites/1/edit
  def edit
    @site = Site.find(params[:id])

    respond_to do |format|
      format.html # edit.html.erb
      format.js  #edit.js.rjs
    end
  end

  # POST /sites
  # POST /sites.xml
  def create
    @site = Site.new(params[:site])

    respond_to do |format|
      if @site.save
        flash[:notice] = 'Site was successfully created.'
        format.html { redirect_to(@site) }
        format.xml  { render :xml => @site, :status => :created, :location => @site }
        format.js   #create.js.rjs
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
        format.js   #create.js.rjs
      end
    end
  end

  # PUT /sites/1
  # PUT /sites/1.xml
  def update
    @site = Site.find(params[:id])

    respond_to do |format|
      if @site.update_attributes(params[:site])
        flash[:notice] = 'Site was successfully updated.'
        format.html { redirect_to(@site) }
        format.xml  { head :ok }
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.xml
  def destroy
    @site = Site.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.html { redirect_to(sites_url) }
      format.xml  { head :ok }
      format.js
    end
  end


end
