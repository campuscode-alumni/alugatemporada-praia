Rails.application.routes.draw do
  devise_for :owners
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  get '/properties/search/', to: 'properties#search', as: 'search_properties'

  resources :properties do
    resources :proposals
  end

end
