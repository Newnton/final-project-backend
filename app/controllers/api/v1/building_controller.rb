require 'Indirizzo'

class Api::V1::BuildingController < ApplicationController
  def show
    address = Indirizzo::Address.new(params[:address])
    buildings = Building.all.where(street_number: address.number)

    if buildings
      building = buildings.find do |b|
        b.street_name.strip.downcase.match(address.street[0].downcase)
      end
    end

    if building
      buildings_for_average = Building.all.where(
        "property_floor_area < '#{building.property_floor_area + 25_000}'
        and property_floor_area > '#{building.property_floor_area - 25_000}'
        and site_eui < '1000'"
      )
      # .select do |b|
      #   b[:site_EUI] < 1000
      # end
      puts buildings_for_average.average(:site_eui).to_i
      render json: {
        building: building,
        averages: {
          indirect_ghg: buildings_for_average.average(:indirect_ghg_emissions).to_i,
          direct_ghg: buildings_for_average.average(:direct_ghg_emissions).to_i,
          site_eui: buildings_for_average.average(:site_eui).to_i,
          source_eui: buildings_for_average.average(:source_eui).to_i
        }
      }
    else
      render json: { error: 'invalid address' }
    end
  end
end
