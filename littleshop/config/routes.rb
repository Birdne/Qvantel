Rails.application.routes.draw do

  resources :products
  resource :cart
  resources :order_items

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
