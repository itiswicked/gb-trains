Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "stations#index"

  get "/stations", to: "stations#index"
  get "/map", to: "map#index"

  resources :journeys, only: [:create]
end
