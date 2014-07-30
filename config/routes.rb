Sky::Application.routes.draw do
  root :to => 'home#index', as: 'home'
  get 'signin', :to => 'sessions#new', as: 'signin'
  get 'signout', :to => 'sessions#destroy', as: 'signout'
  get 'signup', :to => 'accounts#new', as: 'signup'
  resources :sessions


  scope "api" do
    get 'current_user', :to => 'sessions#current_user', as: 'ca'
    resources :sessions

    resources :temp_imports
    resources :temp_import_details

    resources :products
    resources :product_summaries
    resources :orders
    resources :temp_orders
    resources :order_details
    resources :temp_order_details
    resources :deliveries
    resources :accounts
    get 'merchant_accounts/current_sales', :to => 'merchant_accounts#current_sales', as: 'current_sales'
    get 'merchant_accounts/current_user', :to => 'merchant_accounts#current_user', as: 'current_merchant_user'
    resources :merchant_accounts

    resources :customers
  end
end
