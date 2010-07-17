class CumcrfsController < ApplicationController
  before_filter :store_location, :only => [:index]

  def index
    @subject = Subject.find(params[:subject_id])
    #cumulative forms
    @forms = @subject.form_instances.form_version_form_cumulative_is(true).paginate(:page => params[:page])
    respond_to do |format|
      format.html
    end
  end

  def list
    @subject = Subject.find(params[:subject_id])
    #cumulative forms
    @forms = @subject.study.forms
    respond_to do |format|
      format.html { render :file => 'cumcrfs/list.html.erb' }
      format.js { render :file => 'cumcrfs/list.html.erb' }
    end
  end

end
