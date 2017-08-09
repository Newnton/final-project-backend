class CreateBuilding < ActiveRecord::Migration[5.1]
  def change
    create_table :buildings do |t|
      t.integer :BBL
      t.string :BIN
      t.integer :street_number
      t.string :street_name
      t.string :borough
      t.integer :zipcode
      t.string :on_covered_building_list
      t.string :DOF_Benchmarking_status
      t.string :site_EUI
      t.string :weather_normalized_site_EUI
      t.string :source_EUI
      t.string :weather_normalized_source_EUI
      t.string :indoor_water_intensity
      t.string :reported_water_method
      t.string :energy_star_score
      t.string :total_GHG_emissions
      t.string :direct_GHG_emissions
      t.string :indirect_GHG_emissions
      t.string :property_floor_area
      t.string :primary_property_type
    end
  end
end
