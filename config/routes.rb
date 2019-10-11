Rails.application.routes.draw do
  root 'welcome#index'

  resources :consumers, only: [:index, :create]
  resources :daily_offers, only: [:index, :show, :create] do
    member do
      get :close
      get :open
      get :cashier
    end
  end
  resources :orders, only: [:create, :update, :destroy]
end
