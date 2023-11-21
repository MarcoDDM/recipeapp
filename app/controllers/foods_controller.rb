class FoodsController < ApplicationController
  def index
    @foods = Food.all
    @foods = Food.order(:name).includes(:user)
  end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.new(food_params)
    @food.user = current_user

    if @food.save
      redirect_to foods_path, notice: "Food successfully created!"
    else
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy!
    redirect_to foods_path, notice: "Food successfully deleted!"
  end

  private

  def food_params
    params.require(:food).permit('name', 'measurement_unit', 'price')
  end
end