# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131117180801) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dishes", force: true do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "food_service_id"
    t.string   "description"
    t.boolean  "vegetarian",      default: false, null: false
    t.boolean  "lactose_free",    default: false, null: false
    t.boolean  "gluten_free",     default: false, null: false
  end

  add_index "dishes", ["food_service_id"], name: "index_dishes_on_food_service_id", using: :btree

  create_table "events", force: true do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "cco_id",             null: false
    t.string   "name",               null: false
    t.date     "start",              null: false
    t.date     "end",                null: false
    t.date     "construction_start", null: false
    t.date     "teardown_end",       null: false
    t.boolean  "active",             null: false
  end

  add_index "events", ["active"], name: "index_events_on_active", using: :btree
  add_index "events", ["cco_id"], name: "index_events_on_cco_id", unique: true, using: :btree

  create_table "food_services", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "event_id",   null: false
    t.datetime "opens_at"
    t.datetime "closes_at"
  end

  add_index "food_services", ["closes_at"], name: "index_food_services_on_closes_at", using: :btree
  add_index "food_services", ["event_id"], name: "index_food_services_on_event_id", using: :btree
  add_index "food_services", ["opens_at", "closes_at"], name: "index_food_services_on_opens_at_and_closes_at", using: :btree

  create_table "messages", force: true do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "event_id",                       null: false
    t.datetime "published_at"
    t.datetime "deleted_at"
    t.string   "headline",                       null: false
    t.text     "text",                           null: false
    t.boolean  "on_site",        default: false, null: false
    t.boolean  "on_info_screen", default: false, null: false
    t.integer  "sort_priority",  default: 0,     null: false
  end

  add_index "messages", ["event_id"], name: "index_messages_on_event_id", using: :btree

  create_table "people", force: true do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "cco_id",                  null: false
    t.string   "username",                null: false
    t.boolean  "administrator",           null: false
    t.string   "cco_access_token"
    t.string   "cco_access_token_secret"
  end

  add_index "people", ["cco_id"], name: "index_people_on_cco_id", using: :btree

  create_table "radio_loans", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "radio_order_id", null: false
    t.integer  "radio_id"
    t.string   "description",    null: false
    t.datetime "picked_up_at"
    t.datetime "returned_at"
  end

  add_index "radio_loans", ["radio_id"], name: "index_radio_loans_on_radio_id", using: :btree
  add_index "radio_loans", ["radio_order_id"], name: "index_radio_loans_on_radio_order_id", using: :btree

  create_table "radio_orders", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id",                              null: false
    t.string   "description",                           null: false
    t.datetime "pickup_time",                           null: false
    t.datetime "return_time",                           null: false
    t.integer  "earpieces",                 default: 0, null: false
    t.integer  "earpieces_picked_up",       default: 0, null: false
    t.integer  "earpieces_returned",        default: 0, null: false
    t.integer  "remote_speakers",           default: 0, null: false
    t.integer  "remote_speakers_picked_up", default: 0, null: false
    t.integer  "remote_speakers_returned",  default: 0, null: false
    t.integer  "headsets",                  default: 0, null: false
    t.integer  "headsets_picked_up",        default: 0, null: false
    t.integer  "headsets_returned",         default: 0, null: false
  end

  add_index "radio_orders", ["event_id"], name: "index_radio_orders_on_event_id", using: :btree

  create_table "radios", force: true do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "serial_number"
  end

  add_index "radios", ["serial_number"], name: "index_radios_on_serial_number", using: :btree

  create_table "t_shirt_orders", force: true do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "event_id",     null: false
    t.integer  "person_id",    null: false
    t.string   "model",        null: false
    t.string   "size",         null: false
    t.datetime "picked_up_at"
  end

  add_index "t_shirt_orders", ["event_id"], name: "index_t_shirt_orders_on_event_id", using: :btree
  add_index "t_shirt_orders", ["person_id"], name: "index_t_shirt_orders_on_person_id", using: :btree

end
