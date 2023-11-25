Rails.application.routes.draw do
  root 'public_recipes#index'
  devise_for :users

  resources :users
  resources :recipes do
    member do
      patch 'toggle_privacy'
    end
    resources :general_shopping_lists
    resources :recipe_foods
  end
  resources :foods, only: [:index, :new, :create, :destroy]
end
