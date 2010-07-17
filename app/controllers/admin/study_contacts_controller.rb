class Admin::StudyContactsController < AdminController
  before_filter :get_parent

  # GET /contacts
  # GET /contacts.xml
  def index
    set_current_query(@study)
    page = params[@template.dom_id_nested(:page, @study)]
    @entities = @study.contacts.descend_by_id.search(get_current_search(User)).paginate(:page => page)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entities }
      format.js  {
        if params[@template.dom_id_nested(:commit, @study)].blank? && page.blank?
          render :file => 'admin/study_contacts/index.html.erb'
        else
          render(:update) {|page| page[dom_id(@study, :contacts_index)].replace :file => "admin/study_contacts/index" }
        end
      }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    set_current_query(@study)
    @user = User.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @user }
      format.js   #show.js.rjs
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.xml  { render :xml => @user }
      format.js  #new.js.rjs
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])

    respond_to do |format|
      format.js  #edit.js.rjs
    end
  end

  # POST /users
  # POST /users.xml
  def create
    @user = @study.contacts.build(params[:user])

    respond_to do |format|
      if @study.save
        flash[:notice] = 'User was successfully created.'
        format.xml  { render :xml => @user, :status => :created, :location => @user }
        format.js   #create.js.rjs
      else
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        format.js   #create.js.rjs
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.xml  { head :ok }
        format.js
      else
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  def add
    if @study.contacts.blank?
      @candidates = User.all
    else
      @candidates = User.find(:all, :conditions => ["id NOT IN (?)", [0] | @study.contacts.map(&:id)])
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
      @study.contacts << @users_added
    end

    respond_to do |format|
      format.js
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def remove
    @user = User.find(params[:id])
    @study.contacts.delete(@user)

    respond_to do |format|
      format.xml  { head :ok }
      format.js
    end
  end

  protected

  def get_parent
    @study = Study.find(params[:study_id])
  end

end

