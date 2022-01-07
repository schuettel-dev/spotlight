class CreateCalendarDates < ActiveRecord::Migration[7.0]
  def change
    create_table :calendar_dates do |t|
      t.date :date, null: false, index: { unique: true }
      t.boolean :active, null: false, default: true
      t.datetime :request_window_starts_at, null: false
      t.datetime :request_window_ends_at, null: false
      t.datetime :caretaker_informed_at, null: true
      t.datetime :caretaker_confirmed_light_at, null: true
      t.datetime :caretaker_dismissed_light_at, null: true
      t.datetime :sun_sets_at, null: false

      t.timestamps
    end
  end
end
