class Admin::StudySitesController < AdminController
  before_filter :get_study

  # GET /contacts
  # GET /contacts.xml
  def index
    set_current_query(@study)

    @entities = @study.sites.descend_by_created_at.search(get_current_search(Site)).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entities }
      format.js  {
        if params[@template.dom_id_nested(:commit, @study)].blank? && params[:page].blank?
          render :file => 'admin/study_sites/index.html.erb'
        else
          render(:update) {|page| page[dom_id(@study, :sites_index)].replace :file => "admin/study_sites/index" }
        end
      }
    end
  end

  def show
    set_current_query(@study)
    @site = Site.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @site }
      format.js   #show.js.rjs
    end
  end

  def add
    if @study.sites.blank?
      @candidates = Site.all
    else
      @candidates = Site.find(:all, :conditions => ["id NOT IN (?)", [0] | @study.sites.map(&:id)])
    end

    respond_to do |format|
      format.xml  { head :ok }
      format.js
    end
  end

  def enroll
    @sites_added = []
    unless params[:sites].nil?
      @sites_added = Site.find(params[:sites])
      @study.sites << @sites_added
    end

    respond_to do |format|
      format.js
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.xml
  def remove
    @site = Site.find(params[:id])
    @study.sites.delete(@site)

    respond_to do |format|
      format.xml  { head :ok }
      format.js
    end
  end


  protected

  def get_study
    @study = Study.find(params[:study_id])
  end

end
