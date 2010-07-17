class SiteUsersController < ApplicationController

  before_filter :init_site_and_study

  def index
    @study = Study.find_by_id(params[:filter].try(:[], :study_id))
    @users =
        unless @study.nil?
          @site.studies.find(@study).users
        else
          @site.users
        end
    @users = @users.paginate(:page => params[:page], :per_page => 2)
  end

  def create
  end

  def update
  end

  def destroy
    # destroy from users
    @user = User.find(params[:id])
    # @user.destroy #TODO: uncomment this when implement soft delete

    respond_to { |format|
      format.html{
        redirect_to :action=>:index
      }
      format.js
    }
  end

  def destroy_from_study
     # destroy user from study site user
     @study_site_user = StudySiteUser.
         study_site_user(params[:study_id], @site, params[:id] ).first
     @study_site_user.destroy
    respond_to { |format|
      format.html{
        redirect_to :action=>:index
      }
      format.js
    }
  end

  def roles
    #TODO:  add security
    @user = User.find(params[:id])
    @user_roles = Role.site_level.
        study_site_user_roles(
            params[:study_id], @site.id, @user.id
        ).all.collect(&:id)
    @available_roles = Role.site_level.all

    render :layout=>false
  end

  def update_roles
    @study_site_user = StudySiteUser.
        study_site_user(params[:study_id], @site, params[:id] ).first

    if params[:enable].eql? "true"
      @study_site_user.role_study_site_users.create(
          :role_id=>params[:role_id]
      )
    else
      RoleStudySiteUser.destroy_all(
          :role_id=>params[:role_id], :study_site_user_id=>@study_site_user
      )
    end

    render :text=>"ok"
  rescue
    render :text=>"fail"
  end

  private

  def init_site_and_study
    @site = current_user.sites.first
  end

end
