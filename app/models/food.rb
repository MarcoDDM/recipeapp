class Food < ApplicationRecord
  belongs_to :user, class_name: 'User'

  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
