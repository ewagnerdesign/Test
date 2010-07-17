class Admin::SiteContactsController < AdminController
  before_filter :get_parent

  # GET /contacts
  # GET /contacts.xml
  def index
    set_current_query(@site)
    page = params[@template.dom_id_nested(:page, @site)]
    @entities = @site.contacts.ascend_by_id.search(get_current_search(User)).paginate(:page => page)

    respond_to do |format|
      format.xml  { render :xml => @entities }
      format.js  {
        if params[@template.dom_id_nested(:commit, @site)].blank? && page.blank?
          render :file => 'admin/site_contacts/index.html.erb'
        else
          render(:update) {|page| page[dom_id(@site, :contacts_index)].replace :file => "admin/site_contacts/index" }
        end
      }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    set_current_query(@site)
    @user = User.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @user }
      format.js   #show.js.rjs
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @user = @site.contacts.new

    respond_to do |format|
      format.xml  { render :xml => @user }
      format.js  #new.js.rjs #{render :file => 'admin/site_contacts/new.html.erb'}
    end
  end

  # GET /contacts/1/edit
  def edit
    @user = User.find(params[:id])

    respond_to do |format|
      format.js  #edit.js.rjs
    end
  end

  # POST /contacts
  # POST /contacts.xml
  def create
    @user = @site.contacts.new(params[:user])

    respond_to do |format|
      if @site.save
        flash[:notice] = 'Contact was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
        format.js   #create.js.rjs
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        format.js   #create.js.rjs
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Contact was successfully updated.'
        format.xml  { head :ok }
        format.js
      else
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  def add
    if @site.contacts.blank?
      @candidates = User.all
    else
      @candidates = User.find(:all, :conditions => ["id NOT IN (?)", [0] | @site.contacts.map(&:id)])
    end

    respond_to do |format|
      format.xml  { head :ok }
      format.js
    end
  end

  def enroll
    @users_added = []
    unless params[:contacts].nil?
      @users_added = User.find(params[:contacts])
      @site.contacts << @users_added
    end

    respond_to do |format|
      format.js
    end
  end

  def remove
    @user = User.find(params[:id])
    @site.contacts.delete(@user)

    respond_to do |format|
      format.xml  { head :ok }
      format.js
    end
  end

  protected

  def get_parent
    @site = Site.find(params[:site_id])
  end
end
