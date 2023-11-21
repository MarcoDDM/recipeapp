Rails.application.routes.draw do
  devise_for :users

  resources :users
  resources :foods, only: [:index, :new, :create, :destroy]
end
