# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_23_090248) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendar_dates", force: :cascade do |t|
    t.date "date", null: false
    t.integer "light_requests_count", default: 0, null: false
    t.datetime "caretaker_informed_at", precision: 6
    t.datetime "caretaker_confirmed_light_at", precision: 6
    t.datetime "caretaker_dismissed_light_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["date"], name: "index_calendar_dates_on_date", unique: true
  end

  create_table "configurations", force: :cascade do |t|
    t.string "key", null: false
    t.json "value_json", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["key"], name: "index_configurations_on_key", unique: true
  end

  create_table "light_requests", force: :cascade do |t|
    t.bigint "calendar_date_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["calendar_date_id"], name: "index_light_requests_on_calendar_date_id"
    t.index ["user_id"], name: "index_light_requests_on_user_id"
  end

  create_table "request_deadlines", force: :cascade do |t|
    t.integer "weekday", null: false
    t.time "time", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["weekday"], name: "index_request_deadlines_on_weekday", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "role", default: "user", null: false
    t.string "status", default: "unverified", null: false
    t.integer "light_requests_count", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "light_requests", "calendar_dates"
  add_foreign_key "light_requests", "users"
end
