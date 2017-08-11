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
      buildings_for_average = Building.all.where("property_floor_area < '#{building.property_floor_area + 25_000}' and property_floor_area > '#{building.property_floor_area - 25_000}'")
      render json: {
        building: building,
        averages: {
          indirectGHG: buildings_for_average.average(:indirect_GHG_emissions).to_i,
          directGHG: buildings_for_average.average(:direct_GHG_emissions).to_i
        }
      }
    else
      render json: { error: 'invalid address' }
    end
  end
end
