class Admin::UserStudyRolesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @study_users = @user.study_users
    # roles for the first selected study
    @roles = Role.study_level
    @study_user = StudyUser.find_by_id(params[:study_user_id]) || @study_users.first
    @selected_roles = @study_user.try(:roles) || []

    respond_to do |format|
      format.html # index.html.erb
      format.js { render :file => 'admin/user_study_roles/index.html.erb' }
    end
  end

  def update
    study_user = StudyUser.find(params[:id])
    study_user.roles = Role.study_level.find_all_by_id(params[:roles])

    respond_to do |format|
      if study_user.save
        flash[:notice] = 'Roles were successfully updated.'
      else
        flash[:notice] = 'Roles were not updated.'
      end

      format.html { redirect_to :action => "index" }
      format.js   { redirect_to :action => "index", :format => :js }
    end

  end

  def new
    @user = User.find(params[:user_id])
    @studies = Study.id_not_in(@user.studies)

    respond_to do |format|
      format.html { render :partial => "new"}
    end
  end

  def create
    user = User.find(params[:user_id])
    user.studies << Study.find_all_by_id(params[:studies])

    respond_to do |format|
      if user.save
        flash[:notice] = 'Studies were successfully added.'
      else
        flash[:notice] = 'Studies were not added.'
      end

      format.html { redirect_to :action => "index" }
      format.js   { redirect_to :action => "index", :format => :js }
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @study_user = StudyUser.find(params[:id])
    @study_user.destroy

    respond_to do |format|
      format.html { redirect_to :action => "index", :study_user_id => params[:study_user_id] }
      format.js { redirect_to :action => "index", :study_user_id => params[:study_user_id], :format => :js }
    end
  end

  def add_sites
    @user = User.find(params[:user_id])
    @study_user = StudyUser.find(params[:id])
    @sites = @study_user.study.sites
    @selected_sites = @study_user.sites

    respond_to do |format|
      format.html { render :partial => "add_sites"}
    end
  end

  def assign_sites
    @study_user = StudyUser.find(params[:id])
    @study_user.sites = Site.find_all_by_id(params[:sites])

    if @study_user.save
      flash[:notice] = 'Sites were successfully updated.'
    else
      flash[:notice] = 'Sites were not updated.'
    end

    respond_to do |format|
      format.html { render :text => "OK" }
      format.js   { render :text => "OK" }
    end
  end


end



