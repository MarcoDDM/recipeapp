class RecipesController < ApplicationController
  def index
    @recipes = if current_user
                 current_user.recipes.all
               else
                 [] # Set an empty array if there is no current user
               end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods.includes(:food)
  end

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

  def toggle_privacy
    @recipe = Recipe.find(params[:id])
    if @recipe.public == true
      @recipe.update(public: false)
    else
      @recipe.update(public: true)
    end
    redirect_to recipe_path @recipe
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public)
  end
end
