class PriceRangesController < ApplicationController
  def new
    @property = Property.find(params[:property_id])
    @price_range = PriceRange.new
  end

  def create
    @property = Property.find(params[:property_id])
    price_range_params = params.require(:price_range).permit(:description, :start_date, :end_date, :daily_rate)
    @price_range = PriceRange.create(price_range_params)
    @price_range.property = @property
    if @price_range.save
      redirect_to property_path(@property)
      flash[:notice] = "Temporada cadastrada com sucesso!"
    else
      flash[:error] = "Todos os campos devem ser preenchidos"
      render :new
    end
  end
end
