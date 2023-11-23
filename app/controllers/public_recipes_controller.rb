class PublicRecipesController < ApplicationController
  def index
    @recipes = Recipe.includes(:user, recipe_foods: [:food]).where(public: true).all
    @recipes = Recipe.order(created_at: :desc)
    @food = current_user.foods
  end
end
