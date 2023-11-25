require 'rails_helper'

RSpec.feature 'Recipes new Page', type: :feature do
  before do
    user = User.create(name: 'Marco', email: 'example@mail.com', password: 'password',
                       password_confirmation: 'password')
    recipe = Recipe.create(name: 'Asado', preparation_time: 12, cooking_time: 2, description: 'Desc', public: true,
                           user:)
    login_as(user)
    visit new_recipe_path(recipe)
  end

  describe 'Recipes new Page' do
    it 'Should add a new recipe', js: true do
      fill_in 'recipe_name', with: 'Pasta'
      fill_in 'Description', with: 'Pasta Desc'
      fill_in 'Preparation time', with: '30'
      fill_in 'Cooking time', with: '30'
      check('Public')

      click_button 'Create Recipe'

      expect(page).to have_current_path(recipes_path)
      expect(page).to have_content('Pasta')
      expect(page).to have_content('Pasta Desc')
    end
  end
end
