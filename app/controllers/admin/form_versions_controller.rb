class Admin::FormVersionsController < AdminController
  before_filter :get_parent
  before_filter :get_form_version, :only => [:destroy]

  def index
    @form_versions = @form.form_versions
    respond_to do |format|
      format.html { render :file => 'admin/form_versions/index.html.erb' }
    end
  end

  def publish
    t = params[:form_versions]
  end

  # DELETE /forms/1
  # DELETE /forms/1.xml
  def destroy
    @form_version.destroy

    respond_to do |format|
      format.js   { render (:update) {|page| page[dom_id_nested(:item, @form_version)].remove() } }
    end
  end

  protected

  def get_parent
    @study = Study.find(params[:study_id])
    @form = Form.find(params[:form_id])
  end

  def get_form_version
    @form_version = FormVersion.find(params[:id])
  end
end
