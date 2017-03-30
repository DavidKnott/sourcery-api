class Location < ApplicationRecord
  validates_presence_of :creator, :physical_address, :city, :state, :country, :ethereum_address

  def self.get_details_for(locations)
    return false unless all_ethereum_addresses_valid?(locations)
    locations.map do |ethereum_address|
      find_by(ethereum_address: ethereum_address)
    end
  end

  def self.all_ethereum_addresses_valid?(locations)
    locations.all? do |ethereum_address|
      find_by(ethereum_address: ethereum_address)
    end
  end
end