class HomeController < ApplicationController
  def index
    @properties = Property.order(created_at: :desc).limit(10)

    if @properties.empty?
      flash[:notice] = "Não encontramos nenhum imóvel cadastrado" 
    end
  end
end
