# app/controllers/general_shopping_lists_controller.rb
class GeneralShoppingListsController < ApplicationController
  def index
    @user = current_user
    @recipes = @user.recipes.includes(:recipe_foods)
    @general_food_list = @user.foods

    # Calculate the missing foods with quantity
    @missing_foods = calculate_missing_foods_with_quantity
  end

  private

  def calculate_missing_foods_with_quantity
    missing_foods_with_quantity = Hash.new(0)

    @recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        food = recipe_food.food
        missing_foods_with_quantity[food] += recipe_food.quantity.to_i if food.is_a?(Food)
      end
    end

    @general_food_list.each do |food|
      missing_foods_with_quantity[food] = 1 unless missing_foods_with_quantity.key?(food) && food.is_a?(Food)
    end

    missing_foods_with_quantity
  end
end
