class Admin::StudySiteContactsController < AdminController
  before_filter :get_study_site

  def index
    set_current_query(@site)
    page = params[@template.dom_id_nested(:page, @study, @site)]

    @entities = @study.site_contacts(@site).ascend_by_id.search(get_current_search(SiteUser)).paginate(:page => page)

    respond_to do |format|
      format.xml  { render :xml => @entities }
      format.js  {
        if params[@template.dom_id_nested(:commit, @site)].blank? && page.blank?
          render :file => 'admin/study_site_contacts/index.html.erb'
        else
          render(:update) {|page| page[dom_id(@study, dom_id(@site, :contacts_index))].replace :file => "admin/study_site_contacts/index" }
        end
      }
    end
  end

  def show
    set_current_query(@site)
    @user = User.find(params[:id])
    @site_user = @study.site_contacts(@site).user_id_eq(@user.id).first

    respond_to do |format|
      format.xml  { render :xml => @user }
      format.js   #show.js.rjs
    end
  end

  def add
    @candidates = @site.site_users.find(:all, :conditions => ["user_id NOT IN (?)", [0] | @study.site_contacts(@site).map(&:user_id)])

    respond_to do |format|
      format.xml  { head :ok }
      format.js
    end
  end

  def enroll
    @site_users_added = []
    unless params[:site_contacts].nil?
      @site_users_added = SiteUser.find_all_by_id(params[:site_contacts])
      @study.site_users << @site_users_added
    end

    respond_to do |format|
      format.xml  { head :ok }
      format.js
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def remove
    @site_user = SiteUser.find(params[:id])
    @study.site_users.delete(@site_user)

    respond_to do |format|
      format.xml  { head :ok }
      format.js
    end
  end

  protected

  def get_study_site
    @study = Study.find(params[:study_id])
    @site = Site.find(params[:site_id])
  end



end
