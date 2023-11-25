require 'rails_helper'

RSpec.feature 'Recipes Show Page', type: :feature do
  before do
    user = User.create(name: 'Marco', email: 'example@mail.com', password: 'password',
                       password_confirmation: 'password')
    @recipe = Recipe.create(name: 'Asado', preparation_time: 12, cooking_time: 2, description: 'Desc', public: true,
                            user:)
    login_as(user)
    visit recipes_path
  end

  describe 'Recipes Show Page' do
    it 'Should redirect me to Recipe show section and see the recipe details', js: true do
      click_link 'Asado'

      expect(page).to have_current_path(recipe_path(@recipe))
      expect(page).to have_content('Asado')
      expect(page).to have_content('Preparation Time: 12')
      expect(page).to have_content('Cooking Time: 2')
      expect(page).to have_content('Steps go here...')
      expect(page).to have_content('Desc')
      expect(page).to have_content('Public: true')
    end
  end
end
