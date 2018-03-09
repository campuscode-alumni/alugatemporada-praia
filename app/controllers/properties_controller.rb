class PropertiesController < ApplicationController

  def show
    @property = Property.find params[:id]
    @price_ranges = @property.price_ranges
  end

  def search
    @location = params[:location]
    @image = "teste.jpg"

    @properties = Property.where('property_location = ? ', @location)
  end

  def my_properties
    @properties = Property.all
  end

end
