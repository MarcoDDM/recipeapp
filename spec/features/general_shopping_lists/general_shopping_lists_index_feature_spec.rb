require 'rails_helper'

RSpec.feature 'General Shopping Lists Index Page', type: :feature do
  before do
    user = User.create(name: 'Felipe', email: 'example@mail.com', password: 'password',
                       password_confirmation: 'password')
    food = Food.create(name: 'Apple', measurement_unit: 'kg', price: 2, quantity: 2, user:)
    recipe = Recipe.create(name: 'Asado', preparation_time: 12, cooking_time: 2, description: 'Desc', public: true,
                           user:)
    @recipe_food = RecipeFood.create(quantity: 1, recipe:, food:)
    login_as(user)
    visit recipe_general_shopping_lists_path(recipe)
  end

  describe 'General Shopping Lists Index' do
    it 'Should see all the Shopping list details', js: true do
      expect(page).to have_content('Apple')
      expect(page).to have_content('2')
      expect(page).to have_content('Amount of food items to buy: 1')
      expect(page).to have_content('Total value of food needed: $2')
    end
  end
end
