Sky::Application.routes.draw do
  resources :products
  resources :product_summaries

  root :to => 'home#index', as: 'home'
  scope "api" do
    resources :products
  end


end
