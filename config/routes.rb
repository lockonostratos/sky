Sky::Application.routes.draw do
  resources :products
  root :to => 'home#index', as: 'home'
end
