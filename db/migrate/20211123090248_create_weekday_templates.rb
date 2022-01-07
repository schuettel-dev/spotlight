class CreateWeekdayTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :weekday_templates do |t|
      t.integer :weekday, null: false, index: { unique: true }
      t.time :request_window_starts_at, null: false
      t.time :request_window_ends_at, null: false
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
