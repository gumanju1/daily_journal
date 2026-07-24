Rails.application.routes.draw do
  get "entries/index"
  get "entries/new"
  root "users#new"

  get "/signup", to: "users#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :entries
end
