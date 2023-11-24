class AddTimestampsToAllTables < ActiveRecord::Migration[7.0]
  TABLES = [:foods, :recipes, :recipe_foods]
  def change
    TABLES.each do |table|
      add_timestamps table, default: -> { 'CURRENT_TIMESTAMP' }, null: false
    end
  end
end
