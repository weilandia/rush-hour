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

ActiveRecord::Schema.define(version: 20160209172850) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "event"
  end

  create_table "payload_requests", force: :cascade do |t|
    t.string   "ip"
    t.string   "url"
    t.string   "referredBy"
    t.string   "parameters"
    t.integer  "respondedIn"
    t.datetime "requestedAt"
    t.string   "userAgent"
    t.string   "resolution_id"
    t.string   "request_type_id"
    t.string   "event_id"
    t.string   "user_agent_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "request_types", force: :cascade do |t|
    t.string "request_type"
  end

  create_table "resolutions", force: :cascade do |t|
    t.string "resolution_width"
    t.string "resolution_height"
  end

  create_table "user_agents", force: :cascade do |t|
    t.string "browser"
    t.string "platform"
  end

end
