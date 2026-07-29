Rails.application.routes.draw do
  get "passwords/new"
  get "passwords/create"
  get "passwords/edit"
  get "passwords/update"
  root "users#new"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :entries

  get "/password/reset",      to: "passwords#new"
  post "/password/reset",      to: "passwords#create"
  get  "/password/reset/edit", to: "passwords#edit", as: :edit_password_reset
  patch "/password/reset",     to: "passwords#update"
end
