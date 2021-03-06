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
    t.bigint "bbl"
    t.string "bin"
    t.string "street_number"
    t.string "street_name"
    t.string "borough"
    t.integer "zipcode"
    t.string "on_covered_building_list"
    t.string "dof_benchmarking_status"
    t.float "site_eui"
    t.float "weather_normalized_site_eui"
    t.float "source_eui"
    t.float "weather_normalized_source_eui"
    t.float "indoor_water_intensity"
    t.string "reported_water_method"
    t.integer "energy_star_score"
    t.float "total_ghg_emissions"
    t.float "direct_ghg_emissions"
    t.float "indirect_ghg_emissions"
    t.integer "property_floor_area"
    t.string "primary_property_type"
    t.float "lat"
    t.float "lng"
  end

end
