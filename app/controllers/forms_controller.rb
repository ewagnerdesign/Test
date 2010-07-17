class FormsController < ApplicationController
  def index
    study_id = params[:search] ? params[:search][:study_id].try(:to_i) : 0
    @forms = (study_id.zero?) ? [] : Form.visits_study_id_eq(study_id).all.uniq

    respond_to do |format|
      format.json { render :json => @forms }
    end
  end
end
