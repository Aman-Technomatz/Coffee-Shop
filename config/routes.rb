Rails.application.routes.draw do
  resources :discounts
  resources :taxes
  resources :orders
  root "items#index"
  resources :items
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
