class PriceRangesController < ApplicationController
  def new
    @property = Property.find(params[:property_id])
    @price_range = PriceRange.new
  end

  def create
    @property = Property.find(params[:property_id])
    @price_range = PriceRange.new(price_range_params)
    @price_range.property = @property
    if @price_range.save
      redirect_to property_path(@property)
      flash[:notice] = "Temporada cadastrada com sucesso!"
    else
      flash[:error] = "Todos os campos devem ser preenchidos"
      render :new
    end

    # @start_date = price_range_params[:start_date]
    # @end_date = price_range_params[:end_date]
    #
    # @exist_price_range = PriceRange.where("property_id = ?
    #   and ((start_date <= ? and end_date >= ?)
    #   or (start_date <= ? and end_date >= ?))
    #   ", @property, @start_date, @start_date, @end_date, @end_date )
    #
    # if @exist_price_range.any?
    #   flash[:error] = "A data informada já consta cadastrada em outra temporada"
    #   render :new
    # else

  end

  private
  def price_range_params
    params.require(:price_range).permit(:description,
      :start_date, :end_date, :daily_rate)
  end
end
