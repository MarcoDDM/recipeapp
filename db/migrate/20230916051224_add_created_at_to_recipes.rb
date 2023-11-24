class AddCreatedAtToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :created_at, :datetime
  end
end
