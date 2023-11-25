require 'rails_helper'

RSpec.describe Food, type: :model do
  before do
    @user = User.create(name: 'Felipe', email: 'example@mail.com', password: 'password',
                        password_confirmation: 'password')
    Food.create(name: 'Apple', measurement_unit: 'kg', price: 2, quantity: 2, user: @user)
  end

  describe 'Foreign keys' do
    it { should belong_to(:user) }
  end

  describe 'Has many...' do
    it { should have_many(:recipe_foods).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:measurement_unit) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end
end
