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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130512183914) do

  create_table "dishes", :force => true do |t|
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "food_service_id"
    t.string   "description"
    t.boolean  "vegetarian",      :default => false, :null => false
    t.boolean  "lactose_free",    :default => false, :null => false
    t.boolean  "gluten_free",     :default => false, :null => false
  end

  add_index "dishes", ["food_service_id"], :name => "index_dishes_on_food_service_id"

  create_table "events", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "cco_id",             :null => false
    t.string   "name",               :null => false
    t.date     "start",              :null => false
    t.date     "end",                :null => false
    t.date     "construction_start", :null => false
    t.date     "teardown_end",       :null => false
    t.boolean  "active",             :null => false
  end

  add_index "events", ["active"], :name => "index_events_on_active"
  add_index "events", ["cco_id"], :name => "index_events_on_cco_id", :unique => true

  create_table "food_services", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "event_id",   :null => false
    t.datetime "opens_at"
    t.datetime "closes_at"
  end

  add_index "food_services", ["closes_at"], :name => "index_food_services_on_closes_at"
  add_index "food_services", ["event_id"], :name => "index_food_services_on_event_id"
  add_index "food_services", ["opens_at", "closes_at"], :name => "index_food_services_on_opens_at_and_closes_at"

  create_table "people", :force => true do |t|
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "cco_id",                  :null => false
    t.string   "username",                :null => false
    t.boolean  "administrator",           :null => false
    t.string   "cco_access_token"
    t.string   "cco_access_token_secret"
  end

  add_index "people", ["cco_id"], :name => "index_people_on_cco_id"

end
