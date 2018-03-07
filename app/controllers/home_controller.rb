class HomeController < ApplicationController
  def index
    @locations = []
    Property.select("property_location").distinct.each do |p|
      @locations << p.property_location
    end
  end
end
