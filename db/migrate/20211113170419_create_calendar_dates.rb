class CreateCalendarDates < ActiveRecord::Migration[7.0]
  def change
    create_table :calendar_dates do |t|
      t.date :date, null: false, index: { unique: true }
      # t.string :status, null: false, default: 'collecting_requests'
      t.integer :light_requests_count, null: false, default: 0
      t.datetime :caretaker_informed_at, null: true
      t.datetime :caretaker_confirmed_light_at, null: true
      t.datetime :caretaker_dismissed_light_at, null: true

      t.timestamps
    end
  end
end
