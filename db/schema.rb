# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_20_182251) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "consumers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "cash", default: 0
  end

  create_table "daily_offers", force: :cascade do |t|
    t.date "day", null: false
    t.string "name", null: false
    t.float "price", null: false
    t.float "shipping", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "closed", default: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "daily_offer_id", null: false
    t.bigint "consumer_id", null: false
    t.integer "number_of_meals", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "meal_paid", default: false
    t.boolean "shipping_paid", default: false
    t.index ["consumer_id"], name: "index_orders_on_consumer_id"
    t.index ["daily_offer_id"], name: "index_orders_on_daily_offer_id"
  end

  add_foreign_key "orders", "consumers"
  add_foreign_key "orders", "daily_offers"
end
