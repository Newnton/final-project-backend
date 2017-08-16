require 'csv'

unless ARGV.length == 2
  puts 'Sorry, incorrect number of arguments.'
  puts "Usage: ruby parse.rb InputFile.csv OutputFile.csv\n"
  exit
end

ET_HEADERS = %w[
  id
  bbl
  bin street_number
  street_name
  borough
  zipcode
  on_covered_buildings_list
  dof_benchmarking_status
  site_eui
  weather_normalized_site_eui
  source_eui
  weather_normalized_source_eui
  indoor_water_intensity
  reported_water_method
  energy_star_score
  total_ghg_emissions
  direct_ghg_emissions
  indirect_ghg_emissions
  property_floor_area
  primary_property_type
].freeze

new_list = []

old_list = CSV.read(ARGV[0], 'r:windows-1251:utf-8', headers: true, skip_blanks: true).reject { |row| row.to_hash.values.all?(&:nil?) }

old_list.each do |row|
  new_list << row
end

CSV.open(ARGV[1], 'wb') do |csv|
  csv << ET_HEADERS
  new_list.each_with_index do |row, i|
    puts row
    csv << [
      i,
      !row['BBL'].nil? ? row['BBL'].strip : nil,
      !row['BIN'].nil? ? row['BIN'].strip : nil,
      !row['street_number'].nil? ? row['street_number'].strip : nil,
      !row['street_name'].nil? || row['street_name'] == '0' ? row['street_name'].strip.downcase.squeeze(' ') : 'Not Available',
      !row['borough'].nil? || row['borough'] == '0' ? row['borough'].strip.downcase : 'Not Available',
      !row['Zipcode'].nil? ? row['Zipcode'].strip : nil,
      !row['on_covered_buildings_list'].nil? || row['on_covered_buildings_list'] == '0' ? row['on_covered_buildings_list'].strip.downcase : 'Not Available',
      !row['DOF_Benchmarking_status'].nil? || row['DOF_Benchmarking_status'] == '0' ? row['DOF_Benchmarking_status'].strip.downcase : 'Not Available',
      !row['site_ghg'].nil? ? row['site_ghg'].strip : nil,
      !row['weather_normalized_site_ghg'].nil? ? row['weather_normalized_site_ghg'].strip : nil,
      !row['source_ghg'].nil? ? row['source_ghg'].strip : nil,
      !row['weather_normalized_source_ghg'].nil? ? row['weather_normalized_source_ghg'].strip : nil,
      !row['indoor_water_intensity'].nil? ? row['indoor_water_intensity'].strip : nil,
      !row['reported_water_method'].nil? || row['reported_water_method'] == '0' ? row['reported_water_method'].strip.downcase : 'Not Available',
      !row['energy_star_score'].nil? ? row['energy_star_score'].strip : nil,
      !row['total_ghg_emissions'].nil? ? row['total_ghg_emissions'].strip : nil,
      !row['direct_ghg_emissions'].nil? ? row['direct_ghg_emissions'].strip : nil,
      !row['indirect_ghg_emissions'].nil? ? row['indirect_ghg_emissions'].strip : nil,
      !row['property_floor_area'].nil? ? row['property_floor_area'].strip : nil,
      !row['primary_property_type'].nil? || row['primary_property_type'] == '0' ? row['primary_property_type'].strip.downcase : 'Not Available'
    ]
  end
end
