require 'rails_helper'

RSpec.feature 'Foods Index Page', type: :feature do
  before do
    user = User.create(name: 'Felipe', email: 'example@mail.com', password: 'password',
                       password_confirmation: 'password')
    Food.create(name: 'Apple', measurement_unit: 'kg', price: 2, quantity: 2, user:)
    login_as(user)
    visit foods_path
  end

  describe 'Foods Index Page' do
    it 'Should see foods table header', js: true do
      expect(page).to have_content('Food')
      expect(page).to have_content('Measurement Unit')
      expect(page).to have_content('Unit Price')
      expect(page).to have_content('Actions')
    end

    it 'Should see foods table content', js: true do
      expect(page).to have_content('Apple')
      expect(page).to have_content('kg')
      expect(page).to have_content('$2')
      expect(page).to have_content('Delete')
    end

    it 'Should redirect me to New food section', js: true do
      click_link 'Add food'

      expect(page).to have_current_path(new_food_path)
    end

    it 'Should delete the food item', js: true do
      click_button 'Delete'

      expect(page).not_to have_content('Apple')
      expect(page).not_to have_content('$2')
    end
  end
end
