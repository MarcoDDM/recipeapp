class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes.all
  end

  def show; end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe was successfully created'
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipes_path, notice: 'Recipe was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  def new
    @recipe = Recipe.new
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public)
  end
end
