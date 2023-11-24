Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :foods
  resources :general_food_lists
  resources :foods
  resources :recipes
  resources :recipe_foods, only: [:new, :create, :index]
  resources :recipes do 
    resources :recipe_foods
    resources :public_togglers 
  end
  root to: "foods#index"
  get '/public_recipes', to: 'recipes#public_recipes'
  get '/general_shopping_lists', to: 'general_shopping_lists#index'
end
