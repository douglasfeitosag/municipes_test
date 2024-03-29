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

ActiveRecord::Schema[7.1].define(version: 2024_02_08_101320) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "citizen_id", null: false
    t.bigint "state_id", null: false
    t.bigint "city_id", null: false
    t.string "zipcode", null: false
    t.string "street", null: false
    t.string "complement"
    t.string "neighbourhood", null: false
    t.string "ibge_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["citizen_id"], name: "index_addresses_on_citizen_id"
    t.index ["city_id"], name: "index_addresses_on_city_id"
    t.index ["state_id"], name: "index_addresses_on_state_id"
  end

  create_table "cities", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id", "name"], name: "index_cities_on_state_id_and_name", unique: true
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "citizens", force: :cascade do |t|
    t.string "name", null: false
    t.string "cpf", null: false
    t.string "cns", null: false
    t.string "email", null: false
    t.date "birthdate", null: false
    t.string "phone", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.index ["name"], name: "index_citizens_on_name"
  end

  create_table "states", force: :cascade do |t|
    t.string "name", null: false
    t.string "acronym", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["acronym"], name: "index_states_on_acronym", unique: true
    t.index ["name"], name: "index_states_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "cities"
  add_foreign_key "addresses", "citizens"
  add_foreign_key "addresses", "states"
end
