class Admin::DomainsController < AdminController

  before_filter :set_current_query
  before_filter :get_domain, :only => [:show, :edit, :update, :destroy]
 
  # GET /domains
  # GET /domains.xml
  def index
    if params[:format] != 'json'
      check_current_query_parent

      if @current_query[:inc_children]
        #TODO May be optimized by performance:
        #  - one request to DB server
        #  - ORDER BY and PAGINATE on server side
        # see searchlogic issue definition at http://github.com/binarylogic/searchlogic/issues/#issue/35
        domains_filtered = Domain.ascend_by_id.search(get_current_search(Domain, @current_query[:query]))
        domains_with_anws_filtered = Domain.ascend_by_id.search(get_current_search(CdashQuestion, @current_query[:query], "cdash_questions"))
        @domains = domains_filtered.all + domains_with_anws_filtered.all
        @domains = @domains.uniq
        @domains.sort!{|x,y| x.code <=> y.code }
        @domains = @domains.paginate :page => (params[@template.dom_id_nested(:page)] ? params[@template.dom_id_nested(:page)] : 1)
      else
        @domains = Domain.ascend_by_code.search(get_current_search(Domain, @current_query[:query])).paginate(:page => params[@template.dom_id_nested(:page)])
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @domains }
      format.json { render :json => Domain.all.to_json(:only => [:id, :code, :name, :definition]) }
      format.js  {
        if params[@template.dom_id_nested(:commit)].blank? && params[@template.dom_id_nested(:page)].blank?
          render :file => 'admin/domains/index.html.erb'
        else
          render (:update){ |page| page[dom_id_nested(:index)].replace :file => "admin/domains/index" }
        end
      }
    end
  end

  # GET /domains/1
  # GET /domains/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @domain }
      format.js   #show.js.rjs
    end
  end

  # GET /domains/new
  # GET /domains/new.xml
  def new
    @domain = Domain.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @domain }
      format.js  #new.js.rjs
    end
  end
                                                                                        
  # GET /domains/1/edit
  def edit
    respond_to do |format|
      format.html # edit.html.erb
      format.js  #edit.js.rjs
    end
  end

  # POST /domains
  # POST /domains.xml
  def create
    @domain = Domain.new(params[:domain]) 
    
    respond_to do |format|
      if @domain.save
        flash[:notice] = 'Domain was successfully created.'
        format.html { redirect_to(@domain) }
        format.xml  { render :xml => @domain, :status => :created, :location => @domain }
        format.js   #create.js.rjs
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @domain.errors, :status => :unprocessable_entity }
        format.js   #create.js.rjs
      end
    end
  end

  # PUT /domains/1
  # PUT /domains/1.xml
  def update
    respond_to do |format|
      if @domain.update_attributes(params[:domain])
        flash[:notice] = 'Domain was successfully updated.'
        format.html { redirect_to(@domain) }
        format.xml  { head :ok }
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @domain.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /domains/1
  # DELETE /domains/1.xml
  def destroy
    @domain.destroy

    respond_to do |format|
      format.html { redirect_to(@domain) }
      format.xml  { head :ok }
      format.js   { render(:update){ |page| page[dom_id(@domain)].remove() } }
    end
  end

  protected

  def get_domain
    @domain = Domain.find(params[:id])
  end

end
