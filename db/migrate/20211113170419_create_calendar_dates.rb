class CreateCalendarDates < ActiveRecord::Migration[7.0]
  def change
    create_table :calendar_dates do |t|
      t.date :date, null: false, index: { unique: true }
      t.datetime :caretaker_informed_at, null: true
      t.datetime :caretaker_confirmed_light_at, null: true
      t.datetime :caretaker_dismissed_light_at, null: true

      t.timestamps
    end
  end
end
