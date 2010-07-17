class StudyArmsController < ApplicationController
  def index
    study_id = params[:search] ? params[:search][:study_id].try(:to_i) : 0
    study = (study_id.zero?) ? nil : Study.find(study_id)
    @study_arms = study.nil? ? [] : study.study_arms.all

    respond_to do |format|
      format.html { render :file => 'study_arms/index.html.erb', :locals => {:study => study} }
      format.json { render :json => @study_arms.to_json }
    end
  end
end
