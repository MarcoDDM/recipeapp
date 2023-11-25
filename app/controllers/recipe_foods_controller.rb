class RecipeFoodsController < ApplicationController
  def index
    @recipe_foods = RecipeFood.all
    @foods = current_user.foods
  end

  def new
    @recipe_food = RecipeFood.new
    @recipe = Recipe.find(params[:recipe_id])
    @foods = current_user.foods
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food.recipe = @recipe

    if @recipe_food.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def destroy
    @foods = current_user.foods
    @recipe_food = RecipeFood.find(params[:recipe_id])
    @recipe_food.destroy!

    redirect_to recipe_recipe_food_path(@foods)
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
