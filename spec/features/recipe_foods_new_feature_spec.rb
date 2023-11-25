require 'rails_helper'

RSpec.feature 'Public Recipes Index Page', type: :feature do
  before do
    user = User.create(name: 'Felipe', email: 'example@mail.com', password: 'password',
                       password_confirmation: 'password')
    Food.create(name: 'Apple', measurement_unit: 'kg', price: 2, quantity: 2, user:)
    Food.create(name: 'Banana', measurement_unit: 'kg', price: 5, quantity: 2, user:)
    @recipe = Recipe.create(name: 'Asado', preparation_time: 12, cooking_time: 2, description: 'Desc', public: true,
                            user:)
    login_as(user)
    visit new_recipe_recipe_food_path(@recipe)
  end

  describe 'Add Ingredient Page' do
    it 'Should', js: true do
      select 'Banana - $5', from: 'recipe_food_food_id'
      fill_in 'Quantity', with: '2'

      click_button 'Add Ingredient'

      expect(page).to have_current_path(recipe_path(@recipe))
      expect(page).to have_content('Banana')
      expect(page).to have_content('2')
      expect(page).to have_content('$10')
    end
  end
end
