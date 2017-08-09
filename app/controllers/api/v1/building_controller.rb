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
      render json: { building: building }
    else
      render json: { error: 'invalid address' }
   end
  end
end
