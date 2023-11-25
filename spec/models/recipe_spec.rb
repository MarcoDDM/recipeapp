require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before do
    user = User.create(name: 'Felipe', email: 'example@mail.com', password: 'password', encrypted_password: 'password')
    Recipe.create(name: 'Asado', preparation_time: 12, cooking_time: 2, description: 'Desc', public: true,
                  user:)
  end

  describe 'Foreign keys' do
    it { should belong_to(:user) }
  end

  describe 'Has many...' do
    it { should have_many(:recipe_foods).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:preparation_time) }
    it { should validate_presence_of(:cooking_time) }
    it { should validate_presence_of(:description) }
    it { should validate_inclusion_of(:public).in_array([true, false]) }
    it { should validate_presence_of(:user_id) }
  end
end
