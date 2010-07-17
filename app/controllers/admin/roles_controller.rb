class Admin::RolesController < AdminController

  before_filter :get_role, :only => [:edit, :update, :destroy]
  before_filter :convert_permissions, :only => [:create, :update]
 
  # GET /roles
  # GET /roles.xml
  def index
    @roles = Role.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @roles }
      format.json { render :json => @roles.to_json(:only => [:id, :code, :name, :definition]) }
      format.js   { render (:update){ |page| page[dom_id_nested(:index)].replace :file => "admin/roles/index" } }
    end
  end

  # GET /roles/new
  # GET /roles/new.xml
  def new
    @role = Role.new(:category => 0)
    @possible_permissions = Permission.by_category(@role.category)

    respond_to do |format|
      format.xml  { render :xml => @role }
      format.js  #new.js.rjs
    end
  end
                                                                                        
  # GET /roles/1/edit
  def edit
    @possible_permissions = Permission.by_category(@role.category)
    respond_to do |format|
      format.js  #edit.js.rjs
    end
  end

  # POST /roles
  # POST /roles.xml
  def create
    @role = Role.new(params[:role])
    
    respond_to do |format|
      if @role.save
        flash[:notice] = 'Role was successfully created.'
        format.xml  { render :xml => @role, :status => :created, :location => @role }
        format.js   #create.js.rjs
      else
        @possible_permissions = Permission.by_category(@role.category)
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
        format.js   #create.js.rjs
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    respond_to do |format|
      if @role.update_attributes(params[:role])
        flash[:notice] = 'Role was successfully updated.'
        format.html { redirect_to(@role) }
        format.xml  { head :ok }
        format.js
      else
        @possible_permissions = Permission.by_category(@role.category)
        format.html { render :action => "edit" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    respond_to do |format|
      if @role.destroy
        format.html { redirect_to(@role) }
        format.js   { render (:update) {|page| page[dom_id_nested(:item, @role)].remove() } }
      else
        flash[:notice] = 'Role was not deleted.'
        format.html { redirect_to roles_path }
        format.js   { render (:update) { |page|  page.alert("Cannot delete role #{@role.name}") }}
      end
    end
  end

  protected

  def get_role
    @role = Role.find(params[:id])
  end

  def convert_permissions
    params[:role][:permissions] = params[:role][:permissions].nil? ? [] : Permission.find(params[:role][:permissions])
  end

end
