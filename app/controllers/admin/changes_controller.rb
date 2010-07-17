class Admin::ChangesController < AdminController
  add_query_filters
  use_hashed_query

  before_filter { |c| c.get_current_search_hash(:model => Audit) }
  before_filter { |c| c.get_current_search_condition_hash(:model => Audit) }

  # GET /changes/1
  # GET /changes/1.xml
  def index
    changes = Audit.created_within_range(@current_query[:created_from], @current_query[:created_to]).descend_by_id.search(@search_params.merge(@search_condition_params))
    @changes = changes.paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end


  # GET /changes/1
  # GET /changes/1.xml
  def show
    @change = Audit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @change }
      format.js   #show.js.rjs
    end
  end
end
