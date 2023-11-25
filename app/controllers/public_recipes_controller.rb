class PublicRecipesController < ApplicationController
  def index
    @recipes = Recipe.includes(:user, recipe_foods: [:food])
      .where(public: true)
      .order(created_at: :desc)
      .all

    @food = current_user.foods
  end
end
