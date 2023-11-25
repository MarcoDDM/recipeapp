require 'rails_helper'

RSpec.feature 'Recipes Edit Page', type: :feature do
  before do
    user = User.create(name: 'Marco', email: 'example@mail.com', password: 'password',
                       password_confirmation: 'password')
    Food.create(name: 'Apple', measurement_unit: 'kg', price: 2, quantity: 2, user:)
    recipe = Recipe.create(name: 'Asado', preparation_time: 12, cooking_time: 2, description: 'Desc', public: true,
                           user:)
    login_as(user)
    visit edit_recipe_path(recipe)
  end

  describe 'Recipes Edit Page' do
    it 'Should edit recipe', js: true do
      fill_in 'Name', with: 'Pasta'
      fill_in 'Preparation Time (minutes)', with: '13'
      fill_in 'Cooking Time (minutes)', with: '30'
      fill_in 'Description', with: 'Pasta'

      click_button 'Update Recipe'

      expect(page).to have_current_path(recipes_path)
      expect(page).to have_content('Pasta')
      expect(page).to have_content('Pasta')
    end
  end
end
