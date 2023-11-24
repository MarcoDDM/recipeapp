class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id

    if @food.save
      flash[:notice] = 'Food was successfully added.'
      redirect_to foods_path
    else
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    puts params[:id]
    @food.destroy
    flash[:notice] = 'Food was successfully deleted.'
    redirect_to foods_path
  end

  def missing_food
    @user = current_user
    @general_food_list = @user.foods.group(:name).select('food.name, SUM(food.quantity) as total_quantity, SUM(food.price * food.quantity) as total_price')

    @food_used_in_recipes = @user.foods.joins(:recipe_foods).group(:name).select('food.name, SUM(recipe_foods.quantity) as total_quantity')

    @missing_food = @general_food_list.map do |general_food|
      used_food = @food_used_in_recipes.find { |food| food.name == general_food.name }
      difference_quantity = used_food ? used_food.total_quantity - general_food.total_quantity : general_food.total_quantity
      if difference_quantity.negative?
        difference_quantity = 0
        general_food.total_price = 0
      else
        general_food.total_price = general_food.total_price * difference_quantity
      end

      {
        name: general_food.name,
        total_quantity: difference_quantity,
        total_price: general_food.total_price
      }
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
