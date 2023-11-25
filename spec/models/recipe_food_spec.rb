require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before do
    user = User.create(name: 'Felipe', email: 'example@mail.com', password: 'password', encrypted_password: 'password')
    food = Food.create(name: 'Apple', measurement_unit: 'kg', price: 2, quantity: 2, user:)
    recipe = Recipe.create(name: 'Asado', preparation_time: 12, cooking_time: 2, description: 'Desc', public: true,
                           user:)
    @recipe_food = RecipeFood.create(quantity: 1, recipe:, food:)
  end

  describe 'Foreign keys' do
    it { should belong_to(:recipe) }
    it { should belong_to(:food) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:recipe_id) }
    it { should validate_presence_of(:food_id) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
  end

  it 'Should return the Recipe name and his User' do
    expect(@recipe_food.recipe.name).to eq('Asado')
    expect(@recipe_food.recipe.user.name).to eq('Felipe')
  end

  it 'Should return the Food name and his User' do
    expect(@recipe_food.food.name).to eq('Apple')
    expect(@recipe_food.food.user.name).to eq('Felipe')
  end
end
