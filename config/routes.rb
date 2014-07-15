Sky::Application.routes.draw do
  root :to => 'home#index', as: 'home'
  scope "api" do
    resources :products
  end
end
