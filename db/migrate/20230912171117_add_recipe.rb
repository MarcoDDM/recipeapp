class AddRecipe < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t| 
      t.string :name, null: false, default: ""
      t.float :preparation_time, null: false, default: ""
      t.float :cooking_time, null: false, default: ""
      t.text :description, null: false, default: ""
      t.boolean :public, null: false, default: false
      t.references :user, foreign_key: { to_table: :users}, on_delete: :cascade
    end
  end
end
