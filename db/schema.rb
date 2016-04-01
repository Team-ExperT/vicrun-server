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

ActiveRecord::Schema.define(version: 20160401010930) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "water_qualities", force: :cascade do |t|
    t.string   "area"
    t.string   "region"
    t.integer  "am_n"
    t.float    "am_min"
    t.float    "am_p25"
    t.float    "am_p50"
    t.float    "am_p75"
    t.float    "am_max"
    t.integer  "ts_n"
    t.float    "ts_min"
    t.float    "ts_p25"
    t.float    "ts_p50"
    t.float    "ts_p75"
    t.float    "ts_max"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "area_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
