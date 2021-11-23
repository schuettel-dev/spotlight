class CreateConfigurations < ActiveRecord::Migration[7.0]
  def change
    create_table :configurations do |t|
      t.string :key, null: false, index: { unique: true }
      t.json :value_json, null: false

      t.timestamps
    end
  end
end
