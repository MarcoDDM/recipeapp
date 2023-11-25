require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create(name: 'Felipe', email: 'example@mail.com', password: 'password',
                        password_confirmation: 'password')
  end

  describe 'Has many...' do
    it { should have_many(:foods).dependent(:destroy) }
    it { should have_many(:recipes).dependent(:destroy) }
  end

  describe 'Authentications' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
  end
end
