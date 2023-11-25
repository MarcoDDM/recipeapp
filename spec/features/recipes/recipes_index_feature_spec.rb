require 'rails_helper'

RSpec.feature 'Recipes Index Page', type: :feature do
  before do
    user = User.create(name: 'Marco', email: 'example@mail.com', password: 'password',
                       password_confirmation: 'password')
    @recipe = Recipe.create(name: 'Asado', preparation_time: 12, cooking_time: 2, description: 'Desc', public: true,
                            user:)
    login_as(user)
    visit recipes_path
  end

  describe 'Recipes Index Page' do
    it 'Should see all the user recipes details', js: true do
      expect(page).to have_content('Asado')
      expect(page).to have_content('Desc')
      expect(page).to have_content('Edit')
      expect(page).to have_content('Remove')
    end

    it 'Should redirect me to Edit food section', js: true do
      click_link 'Edit'

      expect(page).to have_current_path(edit_recipe_path(@recipe))
    end

    it 'Should remove recipe', js: true do
      click_button 'Remove'

      expect(page).not_to have_content('Asado')
      expect(page).not_to have_content('Desc')
    end
  end
end
