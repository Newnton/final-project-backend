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

ActiveRecord::Schema.define(version: 20170808153621) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buildings", force: :cascade do |t|
    t.integer "BBL"
    t.string "BIN"
    t.integer "street_number"
    t.string "street_name"
    t.string "borough"
    t.integer "zipcode"
    t.string "on_covered_building_list"
    t.string "DOF_Benchmarking_status"
    t.string "site_EUI"
    t.string "weather_normalized_site_EUI"
    t.string "source_EUI"
    t.string "weather_normalized_source_EUI"
    t.string "indoor_water_intensity"
    t.string "reported_water_method"
    t.string "energy_star_score"
    t.string "total_GHG_emissions"
    t.string "direct_GHG_emissions"
    t.string "indirect_GHG_emissions"
    t.string "property_floor_area"
    t.string "primary_property_type"
  end

end