class PropertiesController < ApplicationController

  def show
    @property = Property.find params[:id]
  end

  def search
    @location = params[:property_location]
    @image = "teste.jpg"

    @properties = Property.where('property_location = ? ', @location)
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)

    if @property.save
      redirect_to @property
    else
      flash[:notice] = 'Todos os campos devem ser preenchidos'
      render :new
    end
  end

  def property_params
    params.require(:property).permit(:title, :property_type, :description,
      :property_location, :rent_purpose, :accessibility, :petfriendly,
      :smoking_allowed, :total_rooms, :maximum_guests, :minimum_rent,
      :maximum_rent, :daily_rate)
  end

  def my_properties
    @owner = current_owner
    @my_properties = @owner.properties
  end
end
