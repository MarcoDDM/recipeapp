class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :preparation_time
      t.string :cooking_time
      t.text :description
      t.boolean :public
      t.references :user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
