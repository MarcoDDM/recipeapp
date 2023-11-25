class MissingFoodsController < ApplicationController
  def index
    general_food_list = current_user.general_food_list

    recipes = current_user.recipes

    total_food_items = 0
    total_price = 0

    recipes.each do |recipe|
      missing_foods = general_food_list - recipe.foods
      total_food_items += missing_foods.count

      total_price += missing_foods.sum(&:price)
    end

    @missing_foods = general_food_list - recipes.flat_map(&:foods)
    @total_food_items = total_food_items
    @total_price = total_price
  end
end
