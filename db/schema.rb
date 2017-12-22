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

ActiveRecord::Schema.define(version: 20171203224639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "daycarelicenses", force: :cascade do |t|
    t.integer  "ccsf_license_id"
    t.integer  "day_care_provider_id"
    t.datetime "issue_date"
    t.boolean  "exempt"
    t.string   "license_type"
    t.integer  "state_license_number"
    t.integer  "capacity"
    t.integer  "capacity_desired"
    t.integer  "capacity_subsidy"
    t.integer  "age_from_year"
    t.integer  "age_from_month"
    t.integer  "age_to_year"
    t.integer  "age_to_month"
    t.integer  "vacancies"
    t.datetime "ccsf_created_at"
    t.datetime "ccsf_updated_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "daycareproviders", force: :cascade do |t|
    t.integer  "day_care_provider_id"
    t.string   "name"
    t.string   "alternate_name"
    t.string   "contact_name"
    t.string   "phone"
    t.string   "phone_ext"
    t.string   "phone_other"
    t.string   "phone_other_ext"
    t.string   "fax"
    t.string   "email"
    t.string   "url"
    t.string   "address_1"
    t.string   "address_2"
    t.integer  "city_id"
    t.integer  "state_id"
    t.string   "cross_street_1"
    t.string   "cross_street_2"
    t.string   "mail_address_1"
    t.string   "mail_address_2"
    t.string   "mail_city_id"
    t.string   "mail_state_id"
    t.string   "ssn"
    t.string   "tax_id"
    t.datetime "ccsf_created_at"
    t.datetime "ccsf_updated_at"
    t.decimal  "latitude",                         precision: 15, scale: 7
    t.decimal  "longitude",                        precision: 15, scale: 7
    t.integer  "schedule_year_id"
    t.integer  "zip_code_id"
    t.integer  "care_type_id"
    t.string   "description"
    t.string   "licensed_ages"
    t.integer  "neighborhood_id"
    t.integer  "mail_zip_code"
    t.boolean  "accepting_referrals"
    t.boolean  "meals_optional"
    t.integer  "meal_sponsor_id"
    t.string   "english_capability"
    t.integer  "preferred_language_id"
    t.boolean  "potty_training"
    t.string   "co_op"
    t.boolean  "nutrition_program"
    t.string   "cached_geocodable_address_string"
    t.integer  "license_id_1"
    t.integer  "license_id_2"
    t.integer  "license_id_3"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
  end

  create_table "daycareschedulehours", force: :cascade do |t|
    t.integer  "ccsf_schedulehour_id"
    t.integer  "ccsf_schedule_day_id"
    t.integer  "day_care_provider_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "closed"
    t.datetime "ccsf_created_at"
    t.datetime "ccsf_updated_at"
    t.boolean  "open_24"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "dss_ca_gov_day_care_raws", force: :cascade do |t|
    t.string   "capacity"
    t.string   "city"
    t.string   "contact"
    t.string   "county"
    t.string   "districtoffice"
    t.string   "doaddress"
    t.string   "docity"
    t.string   "dostate"
    t.string   "dotelephone"
    t.string   "dozipcode"
    t.string   "facilityname"
    t.string   "facilitynumber"
    t.string   "facilitytype"
    t.string   "lastvisitdate"
    t.string   "licenseeffectivedate"
    t.string   "licensefirstdate"
    t.string   "licenseename"
    t.string   "nbrallvisits"
    t.string   "nbrcmpltvisits"
    t.string   "nbrcmplttypa"
    t.string   "nbrcmplttypb"
    t.string   "nbrcmpltinc"
    t.string   "nbrcmpltuns"
    t.string   "nbrcmpltsub"
    t.string   "nbrcmpltunf"
    t.string   "nbrinspvisits"
    t.string   "nbrinsptypa"
    t.string   "nbrinsptypb"
    t.string   "nbrothervisits"
    t.string   "nbrothertypa"
    t.string   "nbrothertypb"
    t.string   "state"
    t.string   "status"
    t.string   "streetaddress"
    t.string   "telephone"
    t.string   "vstdateall"
    t.string   "vstdatecmplt"
    t.string   "vstdateinsp"
    t.string   "vstdateother"
    t.string   "zipcode"
    t.string   "totcmpvisits"
    t.string   "totsubalg"
    t.string   "totincalg"
    t.string   "totunsalg"
    t.string   "totunfalg"
    t.string   "tottypea"
    t.string   "tottypeb"
    t.string   "cmpcount"
    t.string   "complaintarray"
    t.string   "tsocase"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

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

  create_table "neighborhoods", force: :cascade do |t|
    t.integer  "neighborhood_id"
    t.string   "neighborhood_name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "realdaycareproviders", force: :cascade do |t|
    t.string   "name"
    t.string   "business_name"
    t.string   "phone"
    t.string   "email"
    t.string   "url"
    t.string   "address"
    t.string   "neighborhood"
    t.string   "age_range"
    t.string   "schedule"
    t.integer  "zip_code"
    t.integer  "license_id_1"
    t.integer  "license_id_2"
    t.integer  "license_id_3"
    t.decimal  "latitude",      precision: 15, scale: 7
    t.decimal  "longitude",     precision: 15, scale: 7
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "description"
    t.string   "daycare_type"
  end

end
