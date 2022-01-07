class CreateWeekdayTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :weekday_templates do |t|
      t.integer :weekday, null: false, index: { unique: true }
      t.boolean :active, null: false, default: true
      t.time :request_window_starts_at, null: false
      t.time :request_window_ends_at, null: false

      t.timestamps
    end
  end
end
