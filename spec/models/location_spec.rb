require 'rails_helper'

describe Location do
  context "validations" do
    it { is_expected.to validate_presence_of(:creator) }
    it { is_expected.to validate_presence_of(:physical_address) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:ethereum_address) }
  end

  it "can get return a list of locations given an array ofethereum_addresses" do
    expected_location1 = create(:location, creator: "Ethan", city: "Denver", ethereum_address: '0x7da07904ffc79d7a69afdecb7b1eb0d767b37803')
    expected_location2 = create(:location, creator: "Mike", city: "New York", ethereum_address: '0x3de0d3f530d48edaca9961109956780975b09a56')
    expected_location3 = create(:location, creator: "Nick", city: "Boulder", ethereum_address: '0x267949f57752b54713f15093d35f6cef2ad02c5c')
    
    location_ethereum_addresses = [expected_location1.ethereum_address, expected_location2.ethereum_address, expected_location3.ethereum_address]
    
    actual_locations = Location.get_details_for(location_ethereum_addresses)

    expect(actual_locations[0].creator).to eq "Ethan"
    expect(actual_locations[0].city).to eq "Denver"
    expect(actual_locations[1].creator).to eq "Mike"
    expect(actual_locations[1].city).to eq "New York"
    expect(actual_locations[2].creator).to eq "Nick"
    expect(actual_locations[2].city).to eq "Boulder"
  end

  it "can return false if any of the given ethereum_addresses are invalid" do
    expected_location1 = create(:location, creator: "Ethan", city: "Denver", ethereum_address: '0x7da07904ffc79d7a69afdecb7b1eb0d767b37803')
    expected_location2 = create(:location, creator: "Mike", city: "New York", ethereum_address: '0x3de0d3f530d48edaca9961109956780975b09a56')
    expected_location3 = create(:location, creator: "Nick", city: "Boulder", ethereum_address: '0x267949f57752b54713f15093d35f6cef2ad02c5c')
    invalid_address = '0x000000007752b54713f15093d35f6cef2ad02c5c'

    location_ethereum_addresses = [invalid_address, expected_location2.ethereum_address, expected_location3.ethereum_address]
    
    invalid_locations = Location.get_details_for(location_ethereum_addresses)

    expect(invalid_locations).to eq false
  end
end