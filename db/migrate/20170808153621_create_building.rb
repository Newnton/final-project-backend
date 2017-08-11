class CreateBuilding < ActiveRecord::Migration[5.1]
  def change
    create_table :buildings do |t|
      t.bigint :BBL
      t.string :BIN
      t.string :street_number
      t.string :street_name
      t.string :borough
      t.integer :zipcode
      t.string :on_covered_building_list
      t.string :DOF_Benchmarking_status
      t.float :site_EUI
      t.float :weather_normalized_site_EUI
      t.float :source_EUI
      t.float :weather_normalized_source_EUI
      t.float :indoor_water_intensity
      t.string :reported_water_method
      t.integer :energy_star_score
      t.float :total_GHG_emissions
      t.float :direct_GHG_emissions
      t.float :indirect_GHG_emissions
      t.integer :property_floor_area
      t.string :primary_property_type
    end
  end
end
