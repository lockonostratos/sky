Sky::Application.routes.draw do
  root :to => 'home#index', as: 'home'
  get 'signin', :to => 'home#signin', as: 'signin'

  scope "api" do
    resources :products
    resources :product_summaries
  end


end
