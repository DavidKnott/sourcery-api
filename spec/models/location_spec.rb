require 'rails_helper'

describe Location do
  context "validations" do
    it { is_expected.to validate_presence_of(:creator) }
    it { is_expected.to validate_presence_of(:street_address) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:ethereum_address) }
    it { is_expected.to validate_presence_of(:lat) }
    it { is_expected.to validate_presence_of(:lng) }
    it { is_expected.to validate_presence_of(:zipcode) }
  end

  describe ".get_details_for" do
    it "can get return a list of locations given an array ofethereum_addresses" do
      create_list(:location, 3)
      
      ethereum_addresses = Location.pluck(:ethereum_address)
      actual_locations = Location.get_details_for(ethereum_addresses)

      expect(actual_locations[0].creator).to eq Location.first.creator
      expect(actual_locations[0].city).to eq Location.first.city
      expect(actual_locations[1].creator).to eq Location.second.creator
      expect(actual_locations[1].city).to eq Location.second.city
      expect(actual_locations[2].creator).to eq Location.third.creator
      expect(actual_locations[2].city).to eq Location.third.city
    end
  end

  describe ".all_ethereum_addresses_valid?" do
    it "can return false if any of the given ethereum_addresses are invalid" do
      create_list(:location, 3)
      invalid_address = '0x000000007752b54713f15093d35f6cef2ad02c5c'

      ethereum_addresses = Location.pluck(:ethereum_address).push(invalid_address)
      invalid_locations = Location.get_details_for(ethereum_addresses)

      expect(invalid_locations).to eq false
    end
  end

  describe ".invalid_addresses" do
    it "returns an array of invalid addresses" do
      create_list(:location, 3)
      invalid_address  = '0x000000007752b54713f15093d35f6cef2ad02c5c'
      invalid_address2 = '0x00000000bad2b54713f15093d35f6cef2ad02c5c'
      
      addresses = Location.pluck(:ethereum_address) + [invalid_address, invalid_address2]
      invalid_addresses = Location.invalid_addresses(addresses)

      expect(invalid_addresses).to eq [invalid_address, invalid_address2]
    end
  end
end
