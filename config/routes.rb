Rails.application.routes.draw do
  root 'public_recipes#index'
  devise_for :users

  resources :users
  resources :recipes do
    member do
      patch 'toggle_privacy'
    end
    resources :shopping_list
    resources :recipe_foods
  end
  resources :foods, only: [:index, :new, :create, :destroy]
end
