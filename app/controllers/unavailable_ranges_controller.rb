class UnavailableRangesController < ApplicationController
  def new
    @unavailable_range = UnavailableRange.new
    @property = Property.find(params[:property_id])
  end

  def create
    range_params = params.require(:unavailable_range).permit(:description,
       :start_date, :end_date, :property_id)
    @property = Property.find(params[:property_id])
    @unavailable_range = @property.unavailable_ranges.build(range_params)
    if @unavailable_range.valid?
      @unavailable_range.save
      redirect_to property_path(@property.id)
    else
      flash[:notice] = "Ops algo está errado."
      render :new
    end
  end
end
