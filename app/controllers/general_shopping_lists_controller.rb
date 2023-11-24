class GeneralShoppingListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @recipes = @user.recipes
    @general_food_list = @user.foods

    calculate_totals
    find_missing_food_items
  end

  private

  def calculate_totals
    @total_quantity_in_recipes = @recipes.flat_map { |recipe| recipe.recipe_foods.map(&:quantity) }.sum
    @total_price_in_recipes = @recipes.flat_map { |recipe| recipe.recipe_foods.map { |rf| rf.food.price * rf.quantity } }.sum
    @total_quantity_in_general_list = @general_food_list.sum(:quantity)
    @total_price_in_general_list = @general_food_list.sum { |food| food.price * food.quantity }
    @missing_quantity = @total_quantity_in_recipes - @total_quantity_in_general_list
    @missing_price = @total_price_in_recipes - @total_price_in_general_list
  end

  def find_missing_food_items
    @missing_food_items = []

    @recipes.each do |recipe|
      recipe.recipe_foods.each do |rf|
        food = rf.food
        general_food = @general_food_list.find_by(id: food.id)

        next unless general_food.present? && rf.quantity > general_food.quantity

        @missing_food_items << {
          food:,
          missing_quantity: rf.quantity - general_food.quantity,
          missing_price: food.price * (rf.quantity - general_food.quantity)
        }
      end
    end
  end
end
