class CreateRequestDeadlines < ActiveRecord::Migration[7.0]
  def change
    create_table :request_deadlines do |t|
      t.integer :weekday, null: false, index: { unique: true }
      t.time :time, null: false
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
