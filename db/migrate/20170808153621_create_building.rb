class CreateBuilding < ActiveRecord::Migration[5.1]
  def change
    create_table :buildings do |t|
      t.bigint :bbl
      t.string :bin
      t.string :street_number
      t.string :street_name
      t.string :borough
      t.integer :zipcode
      t.string :on_covered_building_list
      t.string :dof_benchmarking_status
      t.float :site_eui
      t.float :weather_normalized_site_eui
      t.float :source_eui
      t.float :weather_normalized_source_eui
      t.float :indoor_water_intensity
      t.string :reported_water_method
      t.integer :energy_star_score
      t.float :total_ghg_emissions
      t.float :direct_ghg_emissions
      t.float :indirect_ghg_emissions
      t.integer :property_floor_area
      t.string :primary_property_type
      t.float :lat
      t.float :lng
    end
  end
end
