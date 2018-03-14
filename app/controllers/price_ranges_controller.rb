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

    if @end_date < @start_date
      flash[:error] = "A data fim não pode ser menor do que a data início"
      @price_range = PriceRange.new
      render :new
    else
      @exist_price_range = PriceRange.where("property_id = ?
        and ((start_date <= ? and end_date >= ?)
        or (start_date <= ? and end_date >= ?))
        ", @property, @start_date, @start_date, @end_date, @end_date )

      if @exist_price_range.any?
        flash[:error] = "A data informada já consta cadastrada em outra temporada"
        @price_range = PriceRange.new
        render :new
      else
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
  end
end
