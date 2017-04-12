class Checkpoint < ApplicationRecord
  validates_presence_of :creator,
                        :street_address,
                        :city, 
                        :state,
                        :country,
                        :lat,
                        :lng,
                        :zipcode
  validates_length_of :ethereum_address, minimum: 42, maximum: 42
  validates_uniqueness_of :ethereum_address
  validate :ethereum_address_start
  validate :ethereum_address_hex
  before_validation :generate_ethereum_address

  def self.get_details_for(addresses)
    all_ethereum_addresses_valid?(addresses) &&
      Checkpoint.where(ethereum_address: [addresses])
  end

  def self.all_ethereum_addresses_valid?(addresses)
    addresses.count == Checkpoint.where(ethereum_address: [addresses]).count
  end

  def self.invalid_addresses(addresses)
    addresses.reject { |address| Checkpoint.find_by_ethereum_address(address) }
  end

  private 

    def generate_ethereum_address
      self.ethereum_address ||= '0x' + SecureRandom.hex(20)
    end

    def ethereum_address_start
      if ethereum_address[0..1] != '0x'
        errors.add(:ethereum_address, "must start with '0x'")
      end
    end

    def ethereum_address_hex
      unless ethereum_address[2..-1].chars.all? { |letter| letter =~ /\h/ }
        errors.add(:ethereum_address, "must be composed of hexidecimal characters only")
      end
    end

end
