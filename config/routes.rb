Rails.application.routes.draw do
  root "users#new"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"   # <-- Add this line

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :entries
end
