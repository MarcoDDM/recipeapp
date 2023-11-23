require 'rails_helper'

RSpec.feature 'Public Recipes Index Page', type: :feature do
  before do
    user = User.create(name: 'Felipe', email: 'example@mail.com', password: 'password',
                       password_confirmation: 'password')
    food = Food.create(name: 'Apple', measurement_unit: 'kg', price: 2, quantity: 2, user:)
    recipe = Recipe.create(name: 'Asado', preparation_time: 12, cooking_time: 2, description: 'Desc', public: true,
                           user:)
    @recipe_food = RecipeFood.create(quantity: 1, recipe:, food:)
    login_as(user)
  end

  describe 'Public Recipes Index Page' do
    it 'Should see all the public recipes details', js: true do
      visit root_path
      expect(page).to have_content('Asado')
      expect(page).to have_content('By: Felipe')
      expect(page).to have_content('Total food items: 1')
      expect(page).to have_content('Total price: $2')
    end
  end
end
