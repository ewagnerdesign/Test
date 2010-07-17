class Admin::UserSystemRolesController < AdminController

  # GET /users/:id/roles
  def index
    @roles = Role.system_level
    @user = User.find(params[:user_id])
    @selected_roles = @user.roles

    respond_to do |format|
      format.html # index.html.erb
      format.js { 
        if params[:cancel].blank?
          render :file => 'admin/user_system_roles/index.html.erb'
        else
          render(:update) {|page| page[dom_id(@user, :system_roles_index)].replace :file => 'admin/user_system_roles/index.html.erb' }
        end 
      }
    end
  end

  def create
    @user = User.find(params[:user_id])
    @user.roles = Role.system_level.find_all_by_id(params[:roles])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'Roles were successfully updated.'
      else
        flash[:notice] = 'Roles were not updated.'
      end

      format.html { redirect_to :action => "index" }
      format.js   { redirect_to :action => "index", :format => :js }
    end

    # true
  end

end
