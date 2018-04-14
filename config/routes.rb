Rails.application.routes.draw do
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "products#index"

  namespace :admin do
    resources :products
    root "products#index"
  end

  resources :products ,only:[:index, :show] do
    member do
      post :add_to_cart
    end
  end

  resources :cart_items, only:[:index,:destroy] do
    member do
      post :plus_quantity
      post :minus_quantity
    end
  end
  
end
