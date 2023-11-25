require 'rails_helper'

RSpec.feature 'Food new Page', type: :feature do
  before do
    user = User.create(name: 'Felipe', email: 'example@mail.com', password: 'password',
                       password_confirmation: 'password')
    food = Food.create(name: 'Apple', measurement_unit: 'kg', price: 2, quantity: 2, user:)
    recipe = Recipe.create(name: 'Asado', preparation_time: 12, cooking_time: 2, description: 'Desc', public: true,
                           user:)
    @recipe_food = RecipeFood.create(quantity: 1, recipe:, food:)
    login_as(user)
    visit new_food_path
  end

  describe 'Food new Page' do
    it 'Should submit the form and create a new food item', js: true do
      fill_in 'Name', with: 'Banana'
      select 'kg', from: 'Measurement unit'
      fill_in 'Quantity', with: 3
      fill_in 'Price', with: 1

      click_button 'Add Food'

      expect(page).to have_current_path(foods_path)
      expect(page).to have_content('Food successfully created')
      expect(page).to have_content('Banana')
      expect(page).to have_content('kg')
      expect(page).to have_content('$1')
    end
  end
end
