class Admin::PermissionsController < AdminController

  def index
    @selected_permissions = params[:role_id] ? Role.find(params[:role_id]).permissions : []
    @possible_permissions = params[:search] && params[:search][:category] ? Permission.category_eq(params[:search][:category]) : []
  end
end
