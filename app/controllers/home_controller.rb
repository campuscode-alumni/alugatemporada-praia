class HomeController < ApplicationController
  def index
    @properties = Property.order(created_at: :desc).limit(10)
  end
end
