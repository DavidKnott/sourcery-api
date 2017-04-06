class Location < ApplicationRecord
  validates_presence_of :creator, :street_address, :city, 
                        :state, :country, :ethereum_address,
                        :lat, :lng, :zipcode

  def self.get_details_for(addresses)
    all_ethereum_addresses_valid?(addresses) &&
      Location.where(ethereum_address: [addresses])
  end

  def self.all_ethereum_addresses_valid?(addresses)
    addresses.count == Location.where(ethereum_address: [addresses]).count
  end

  def self.invalid_addresses(addresses)
    addresses.reject { |address| Location.find_by_ethereum_address(address) }
  end
end
