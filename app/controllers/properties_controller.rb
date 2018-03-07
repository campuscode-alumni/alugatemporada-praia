class PropertiesController < ApplicationController
  def search
    @location = params[:location]
    @image = "teste.jpg"

    @properties = Property.where('property_location = ? ', @location)
  end
end
