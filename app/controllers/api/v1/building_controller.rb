require 'Indirizzo'

class Api::V1::BuildingController < ApplicationController
  def show_by_address
    address = Indirizzo::Address.new(params[:address])
    buildings = Building.all.where(street_number: address.number)

    if buildings && address.street[0]
      building = buildings.find do |b|
        b.street_name.strip.downcase.match(address.street[0].downcase)
      end
    end

    show(building)
  end

  def show_by_id
    building = Building.find(params[:id])
    show(building)
  end

  def do_nothing
    render json: {nothing: 'doing nothing'}
  end

  def show(building)
    if building
      buildings_for_average = Building.all.where(
        "property_floor_area < '#{building.property_floor_area + 25_000}'
        and property_floor_area > '#{building.property_floor_area - 25_000}'
        and site_eui < '1000'"
      )
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
      render json: { building: 'Please make sure that you entered a valid address and that the building you are looking for is larger than 50,000 sqft' }
    end
  end

  def borough_buildings(borough)
    Building.all.where(borough: borough).map do |building|
      {
        id: building.id,
        lat: building.lat,
        lng: building.lng,
        street_number: building.street_number,
        street_name: building.street_name
      }
    end
  end

  def index
    render json: {
      manhattan: self.borough_buildings('manhattan'),
      bronx: self.borough_buildings('bronx'),
      queens: self.borough_buildings('queens'),
      brooklyn: self.borough_buildings('brooklyn'),
      staten: self.borough_buildings('staten island')
    }
  end

  def borough_totals
    manhattan_buildings = Building.all.where(borough: 'manhattan')
    brooklyn_buildings = Building.all.where(borough: 'brooklyn')
    bronx_buildings = Building.all.where(borough: 'bronx')
    queens_buildings = Building.all.where(borough: 'queens')
    staten_buildings = Building.all.where(borough: 'staten island')

    borough_totals = {
      manhattan: {
        total_buildings: manhattan_buildings.length,
        total_direct_ghg: manhattan_buildings.sum(:direct_ghg_emissions).to_i,
        total_indirect_ghg: manhattan_buildings.sum(:indirect_ghg_emissions).to_i,
        average_direct_ghg: manhattan_buildings.average(:direct_ghg_emissions).to_i,
        average_indirect_ghg: manhattan_buildings.average(:indirect_ghg_emissions).to_i,
        total_site_eui: manhattan_buildings.sum(:site_eui).to_i,
        total_source_eui: manhattan_buildings.sum(:source_eui).to_i,
        average_site_eui: manhattan_buildings.average(:site_eui).to_i,
        average_source_eui: manhattan_buildings.average(:source_eui).to_i
      },
      brooklyn: {
        total_buildings: brooklyn_buildings.length,
        total_direct_ghg: brooklyn_buildings.sum(:direct_ghg_emissions).to_i,
        total_indirect_ghg: brooklyn_buildings.sum(:indirect_ghg_emissions).to_i,
        average_direct_ghg: brooklyn_buildings.average(:direct_ghg_emissions).to_i,
        average_indirect_ghg: brooklyn_buildings.average(:indirect_ghg_emissions).to_i,
        total_site_eui: brooklyn_buildings.sum(:site_eui).to_i,
        total_source_eui: brooklyn_buildings.sum(:source_eui).to_i,
        average_site_eui: brooklyn_buildings.average(:site_eui).to_i,
        average_source_eui: brooklyn_buildings.average(:source_eui).to_i
      },
      queens: {
        total_buildings: queens_buildings.length,
        total_direct_ghg: queens_buildings.sum(:direct_ghg_emissions).to_i,
        total_indirect_ghg: queens_buildings.sum(:indirect_ghg_emissions).to_i,
        average_direct_ghg: queens_buildings.average(:direct_ghg_emissions).to_i,
        average_indirect_ghg: queens_buildings.average(:indirect_ghg_emissions).to_i,
        total_site_eui: queens_buildings.sum(:site_eui).to_i,
        total_source_eui: queens_buildings.sum(:source_eui).to_i,
        average_site_eui: queens_buildings.average(:site_eui).to_i,
        average_source_eui: queens_buildings.average(:source_eui).to_i
      },
      bronx: {
        total_buildings: bronx_buildings.length,
        total_direct_ghg: bronx_buildings.sum(:direct_ghg_emissions).to_i,
        total_indirect_ghg: bronx_buildings.sum(:indirect_ghg_emissions).to_i,
        average_direct_ghg: bronx_buildings.average(:direct_ghg_emissions).to_i,
        average_indirect_ghg: bronx_buildings.average(:indirect_ghg_emissions).to_i,
        total_site_eui: bronx_buildings.sum(:site_eui).to_i,
        total_source_eui: bronx_buildings.sum(:source_eui).to_i,
        average_site_eui: bronx_buildings.average(:site_eui).to_i,
        average_source_eui: bronx_buildings.average(:source_eui).to_i
      },
      staten: {
        total_buildings: staten_buildings.length,
        total_direct_ghg: staten_buildings.sum(:direct_ghg_emissions).to_i,
        total_indirect_ghg: staten_buildings.sum(:indirect_ghg_emissions).to_i,
        average_direct_ghg: staten_buildings.average(:direct_ghg_emissions).to_i,
        average_indirect_ghg: staten_buildings.average(:indirect_ghg_emissions).to_i,
        total_site_eui: staten_buildings.sum(:site_eui).to_i,
        total_source_eui: staten_buildings.sum(:source_eui).to_i,
        average_site_eui: staten_buildings.average(:site_eui).to_i,
        average_source_eui: staten_buildings.average(:source_eui).to_i
      }
    }

    render json: borough_totals
  end
end
