require 'csv'
require 'net/http'
require 'json'
require 'byebug'

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
  lat
  lng
].freeze

new_list = []

old_list = CSV.read(ARGV[0], 'r:windows-1251:utf-8', headers: true, skip_blanks: true).reject { |row| row.to_hash.values.all?(&:nil?) }

old_list.each do |row|
  new_list << row unless row['street_name'] == nil
end


def getLatLng (row)
  if row['street_name'] && row['street_number'] && row['zipcode']
    uri = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{row['street_number']}%20#{row['street_name']},%20NY,%20#{row['zipcode']}&key=#{PUT KEY HERE TO MAKE IT WORK}")
    res = Net::HTTP.get(uri)
    res = JSON.parse res.gsub('=>', ':')
    puts res
    if res['results'] == [] && res['status'] != "ZERO_RESULTS"
      sleep(10)
      return getLatLng(row)
    elsif res['status'] == "ZERO_RESULTS"
      return nil
    else
      return res['results'][0]['geometry']['location'] ? res['results'][0]['geometry']['location'] : nil
    end
  else
    return nil
  end
end

CSV.open(ARGV[1], 'wb') do |csv|
  csv << ET_HEADERS
  new_list.each_with_index do |row, i|
    puts row
    latLng = getLatLng(row)
    csv << [
      i,
      !row['bbl'].nil? ? row['bbl'].strip : nil,
      !row['bin'].nil? ? row['bin'].strip : nil,
      !row['street_number'].nil? ? row['street_number'].strip : nil,
      !row['street_name'].nil? || row['street_name'] == '0' ? row['street_name'].strip.downcase.squeeze(' ') : 'Not Available',
      !row['borough'].nil? || row['borough'] == '0' ? row['borough'].strip.downcase : 'Not Available',
      !row['zipcode'].nil? ? row['zipcode'].strip : nil,
      !row['on_covered_buildings_list'].nil? || row['on_covered_buildings_list'] == '0' ? row['on_covered_buildings_list'].strip.downcase : 'Not Available',
      !row['dof_benchmarking_status'].nil? || row['dof_benchmarking_status'] == '0' ? row['dof_benchmarking_status'].strip.downcase : 'Not Available',
      !row['site_eui'].nil? ? row['site_eui'].strip : nil,
      !row['weather_normalized_site_eui'].nil? ? row['weather_normalized_site_eui'].strip : nil,
      !row['source_eui'].nil? ? row['source_eui'].strip : nil,
      !row['weather_normalized_source_eui'].nil? ? row['weather_normalized_source_eui'].strip : nil,
      !row['indoor_water_intensity'].nil? ? row['indoor_water_intensity'].strip : nil,
      !row['reported_water_method'].nil? || row['reported_water_method'] == '0' ? row['reported_water_method'].strip.downcase : 'Not Available',
      !row['energy_star_score'].nil? ? row['energy_star_score'].strip : nil,
      !row['total_ghg_emissions'].nil? ? row['total_ghg_emissions'].strip : nil,
      !row['direct_ghg_emissions'].nil? ? row['direct_ghg_emissions'].strip : nil,
      !row['indirect_ghg_emissions'].nil? ? row['indirect_ghg_emissions'].strip : nil,
      !row['property_floor_area'].nil? ? row['property_floor_area'].strip : nil,
      !row['primary_property_type'].nil? || row['primary_property_type'] == '0' ? row['primary_property_type'].strip.downcase : 'Not Available',
      latLng ? latLng['lat'] : nil,
      latLng ? latLng['lng'] : nil
    ]
  end
end
