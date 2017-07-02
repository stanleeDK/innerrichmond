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

ActiveRecord::Schema.define(version: 20170416205655) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingested_trulia_properties", force: :cascade do |t|
    t.string   "address"
    t.integer  "address_number"
    t.string   "address_number_suffix"
    t.string   "street_name"
    t.string   "street_type"
    t.string   "unit_number"
    t.integer  "zipcode"
    t.string   "size_description"
    t.integer  "bedrooms"
    t.integer  "bathrooms"
    t.integer  "square_feet"
    t.string   "property_page"
    t.decimal  "value"
    t.date     "sold_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "official_address_backup", id: false, force: :cascade do |t|
    t.integer  "id"
    t.integer  "eas_base_id"
    t.integer  "eas_sub_id"
    t.integer  "CNN"
    t.string   "address"
    t.integer  "address_number"
    t.string   "address_number_suffix"
    t.string   "street_name"
    t.string   "street_type"
    t.string   "unit_number"
    t.integer  "zipcode"
    t.integer  "blocklot"
    t.decimal  "long",                  precision: 15, scale: 7
    t.decimal  "lat",                   precision: 15, scale: 7
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "official_addresses", force: :cascade do |t|
    t.integer  "eas_base_id"
    t.integer  "eas_sub_id"
    t.integer  "CNN"
    t.string   "address"
    t.integer  "address_number"
    t.string   "address_number_suffix"
    t.string   "street_name"
    t.string   "street_type"
    t.string   "unit_number"
    t.integer  "zipcode"
    t.integer  "blocklot"
    t.decimal  "long",                  precision: 15, scale: 7
    t.decimal  "lat",                   precision: 15, scale: 7
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

end
