class FdController < ApplicationController

  before_filter :set_current_query, :only => [:get_domains_view]

  # GET /fd/index
  # In most cases for popup dictionary actions
  def index
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

    respond_to do |format|
      format.html { render :layout => false } # index.html.erb
      format.xml  { render :xml => @domains }
      format.json { render :json => Domain.all.to_json(:only => [:id, :code, :name, :definition]) }
      format.js  {
        unless params[@template.dom_id_nested(:commit)].blank? && params[@template.dom_id_nested(:page)].blank?
#          render :file => 'admin/domains/index.html.erb'
#        else
          render (:update){ |page| page[dom_id_nested(:index)].replace :file => "fd/index" }
        end
      }
    end
  end
  
  # GET /fd
  def show

  end

  # GET /fd/1
  def edit
    @form = Form.find(params[:id])
  end

  # GET /fd/get_domains.json
  def get_domains
    render :json => Domain.all.to_json(:only => [:id, :code, :name, :definition])
  end

  def get_domains_view
    index
  end

end
