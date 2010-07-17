class Admin::TherapeuticAreasController < AdminController
  # GET /therapeutic_areas
  # GET /therapeutic_areas.xml
  def index
    areas = TherapeuticArea.name_like(params[:q])
    render :text => areas.map(&:name).uniq.join("\n")
  end

end
