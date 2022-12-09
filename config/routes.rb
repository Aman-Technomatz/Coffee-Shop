Rails.application.routes.draw do
  resources :tax_categories
  resources :discounts
  resources :orders
  root "items#index"
  resources :items
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
