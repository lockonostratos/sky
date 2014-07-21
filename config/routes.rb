Sky::Application.routes.draw do
  root :to => 'home#index', as: 'home'
  get 'signin', :to => 'sessions#new', as: 'signin'
  get 'signout', :to => 'sessions#destroy', as: 'signout'
  get 'signup', :to => 'accounts#new', as: 'signup'
  resources :sessions

  scope "api" do
    resources :products
    resources :product_summaries
    resources :orders
    resources :order_details
    resources :deliveries
    resources :accounts
    resources :merchant_accounts

  end


end
