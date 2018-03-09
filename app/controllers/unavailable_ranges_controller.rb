class UnavailableRangesController < ApplicationController
  def new
    @unavailable_range = UnavailableRange.new
    @property = Property.new
  end

end
