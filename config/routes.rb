Sky::Application.routes.draw do
  root :to => 'home#index', as: 'home'
  get 'signin', :to => 'sessions#new', as: 'signin'
  get 'signout', :to => 'sessions#destroy', as: 'signout'
  get 'signup', :to => 'accounts#new', as: 'signup'
  resources :sessions
  get 'current_user', :to => 'sessions#current_user', as: 'ca'
  get 'current_warehouse_user', :to => 'sessions#current_warehouse_user', as: 'current_warehouse_user'

  scope "api" do
    resources :products
    resources :product_summaries
    resources :orders
    resources :order_details
    resources :deliveries
    resources :accounts
    resources :merchant_accounts
    resources :customers
  end
end
