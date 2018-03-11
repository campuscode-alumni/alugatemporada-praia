class PriceRangesController < ApplicationController
  def new
    @property = Property.find(params[:property_id])
    @price_range = PriceRange.new
  end

  def create
    @property = Property.find(params[:property_id])

    price_range_params = params.require(:price_range).permit(:description,
      :start_date, :end_date, :daily_rate)

    @start_date = price_range_params[:start_date]
    @end_date = price_range_params[:end_date]

    @exist_price_range = PriceRange.where('property_id = ? and
      (start_date <= ? or start_date >= ?) or (end_date <= ? or end_date >= ?)
      ', 1, @start_date, @start_date, @end_date, @end_date )

    if @exist_price_range.empty?
      @price_range = PriceRange.create(price_range_params)
      @price_range.property = @property
      if @price_range.save
        redirect_to property_path(@property)
        flash[:notice] = "Temporada cadastrada com sucesso!"
      else
        flash[:error] = "Todos os campos devem ser preenchidos"
        render :new
      end
    else
      flash[:error] = "A data informada já consta cadastrada em outra temporada"
      @price_range = PriceRange.new
      render :new
    end
  end
end


PriceRange.where('property_id = ? and
  (start_date >= "15/02/2019" and end_date <= "15/02/2019")
  or (start_date >= "20/02/2019" and end_date = "20/02/2019")', 1)
