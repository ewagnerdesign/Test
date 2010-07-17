class EcrmController < ApplicationController
  def save
    directory = "public"
    # create the file path
    path = File.join(directory, "form.json")
    # write the file
    File.open(path, "wb") { |f| f.write(params[:data]) }
    path = File.join(directory, "form.html")
    File.open(path, "wb") { |f| f.write(params[:html]) }
    render :text => params[:data]
  end
end
