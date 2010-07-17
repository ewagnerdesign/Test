class SitesController < ApplicationController
  def index
    study_id = params[:search] ? params[:search][:study_id].try(:to_i) : 0
    study = (study_id.zero?) ? nil : Study.find(study_id)
    @sites = study.nil? ? [] : study.sites.all

    respond_to do |format|
      format.html { render :file => 'sites/index.html.erb', :locals => {:study => study} }
      format.json { render :json => @sites.to_json }
    end
  end
end
