class Admin::StudyCumulativeCrfsController < ApplicationController
  def index
    @study = Study.find(params[:study_id])
    @forms = @study.forms

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entities }
      format.js  {
        if params[@template.dom_id_nested(:commit)].blank?
          render :file => 'admin/study_cumulative_crfs/index.html.erb'
        else
          render(:update) {|page| page[dom_id_nested(:index, @study)].replace_html :file => "admin/study_cumulative_crfs/index" }
        end
      }
    end
  end

  def show
    @study = Study.find(params[:study_id])
    @form = Form.find(params[:id])
    respond_to do |format|
      format.js   #show.js.rjs
    end
  end

  def new
    @study = Study.find(params[:study_id])

    return if params[:cancel]

    @forms = Form.cumulative_forms - @study.forms
    respond_to do |format|
      format.js   #new.js.rjs
    end
  end

  # POST /forms
  # POST /forms.xml
  def create
    @study = Study.find(params[:study_id])

    forms = Form.cumulative_forms.find(params[:forms]) if params[:forms]
    @study.forms += forms unless forms.blank?

    #TODO error processing (example: cumulative forms)
    @forms = @study.forms
    render(:update) {|page| page[dom_id_nested(:index, @study)].replace :file => "admin/study_cumulative_crfs/index.html.erb"}
  end

  def destroy
    @study = Study.find(params[:study_id])
    @study.forms.delete(Form.find(params[:id]))
    @forms = @study.forms
    render(:update) {|page| page[dom_id_nested(:index, @study)].replace :file => "admin/study_cumulative_crfs/index.html.erb"}
  end

end
