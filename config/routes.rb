Rails.application.routes.draw do
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "products#index"

  namespace :admin do
    resources :products
    resources :categories
    resources :orders
    root "products#index"
  end

  resources :products ,only:[:index, :show] do
    member do
      post :add_to_cart
    end

    member do
      post :favorite
      post :unfavorite
    end

    collection do
      get  :ranking
    end
  end

  resources :cart_items, only:[:index,:destroy] do
    member do
      post :plus_quantity
      post :minus_quantity
    end
  end

  resources :orders do
    post :checkout_spgateway, on: :member
  end

  post 'spgateway/return'
  
  resources :categories, only: :show
  resources :orders, only:[:index,:create,:show,:update,:destroy]
end
