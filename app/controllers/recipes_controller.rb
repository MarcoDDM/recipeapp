class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes.all
  end

  def show
    @recipe = current_user.recipes.find(params[:id])
    @foods = @recipe.foods
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

  def public_recipes
    @precipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def missing_food
    @user = current_user
    @general_food_list = @user.foods.group(:name).select('foods.name, SUM(foods.quantity) as total_quantity, SUM(foods.price * foods.quantity) as total_price')

    @food_used_in_recipes = @user.foods.joins(:recipe_foods).group(:name).select('foods.name, SUM(recipe_foods.quantity) as total_quantity')

    @missing_food = @general_food_list.map do |general_food|
      used_food = @food_used_in_recipes.find { |food| food.name == general_food.name }
      difference_quantity = used_food ? used_food.total_quantity - general_food.total_quantity : general_food.total_quantity

      # If difference_quantity is less than zero, set it to zero and total_price to zero as well
      if difference_quantity < 0
        difference_quantity = 0
        general_food.total_price = 0
      else
        general_food.total_price = general_food.total_price * difference_quantity
      end

      OpenStruct.new(name: general_food.name, total_quantity: difference_quantity, total_price: general_food.total_price)
    end
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public)
  end
end
