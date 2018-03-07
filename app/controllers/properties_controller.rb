class PropertiesController < ApplicationController

  def show
    @property = Property.find params[:id]
  end

  def search
    @location = params[:location]
    @image = "teste.jpg"

    @properties = Property.where('property_location = ? ', @location)
  end
end
