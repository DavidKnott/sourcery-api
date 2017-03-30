class Location < ApplicationRecord
  validates_presence_of :creator, :physical_address, :city, :state, :country, :ethereum_address

  def self.get_details_for(locations)
    locations.map do |ethereum_address|
      find_by(ethereum_address: ethereum_address)
    end
  end
end