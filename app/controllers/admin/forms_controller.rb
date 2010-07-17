class Admin::FormsController < AdminController
  # GET /forms
  # GET /forms.xml
  def index
    @forms = Form.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forms }
      format.js { render :layout => false }
    end
  end

  # GET /forms/1
  # GET /forms/1.xml
  def show
    # TODO legacy? 
    @form_rec = Form.find(params[:id]).form_versions.last
    @form = Former.new(@form_rec.form_instances.build)
    @form_data = ActiveSupport::JSON.decode(@form_rec.metadata)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @form }
    end
  end

  # GET /forms/new
  # GET /forms/new.xml
  def new
    @form = Form.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @form }
      format.js {render :json => @form.metadata}
    end
  end

  # GET /forms/1/edit
  def edit
    @form = Form.find(params[:id])
  end

  # POST /forms
  # POST /forms.xml
  def create
    @form = Form.new(params[:form])

    respond_to do |format|
      if @form.save
        #flash[:notice] = 'Form was successfully created.'
        format.html { redirect_to(:admin, @form) }
        format.xml  { render :xml => @form, :status => :created, :location => @form }
        format.json   { render :json => @form.metadata }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @form.errors, :status => :unprocessable_entity }
        format.json   { render :json => {:error => @form.errors.full_messages}.to_json }
      end
    end
  end

  # PUT /forms/1
  # PUT /forms/1.xml
  def update
    @form = Form.find(params[:id])

    respond_to do |format|
      if @form.update_attributes(params[:form])
        flash[:notice] = 'Form was successfully updated.'
        format.html { redirect_to(:admin, @form) }
        format.xml  { head :ok }
        format.json  { render :json => @form.metadata }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @form.errors, :status => :unprocessable_entity }
      end
    end
  end

  #POST /forms/preview
  def preview
    #@formi = Form.build(:metadata => params[:form][:metadata])
    f = FormVersion.new(:metadata => params[:form][:metadata])
    i = FormInstance.new
    i.form_version = f
    @form = Former.new(i)
    @form_data = ActiveSupport::JSON.decode(params[:form][:metadata])

    respond_to do |format|
      format.html { render :partial => "preview" }
    end
  end

  #GET /forms/preview
  def preview_fv
    f = FormVersion.find(params[:form_version_id])
    i = FormInstance.new
    i.form_version = f
    @form = Former.new(i)
    @form_data = ActiveSupport::JSON.decode(f.metadata)
    @hide_menu = true
    respond_to do |format|
      format.html { render :partial => "preview", :layout => "application" }
    end
  end

  # DELETE /forms/1
  # DELETE /forms/1.xml
  def destroy
    @form = Form.find(params[:id])
    @form.destroy

    respond_to do |format|
      format.html { redirect_to(admin_forms_url) }
      format.xml  { head :ok }
    end
  end
end
