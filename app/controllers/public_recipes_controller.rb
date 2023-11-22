class PublicRecipesController < ApplicationController
  def index
    @recipes = Recipe.where(public: true).all
    @food = current_user.foods
  end
end