Rails.application.routes.draw do
  root "entries#index"

  devise_for :users

  resources :entries do
    resources :comments, only: [ :create, :destroy ]
    resources :entry_shares, only: [ :create, :destroy ]
  end
end
