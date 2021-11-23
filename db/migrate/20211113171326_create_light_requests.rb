class CreateLightRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :light_requests do |t|
      t.belongs_to :calendar_date, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
