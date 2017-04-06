require "rails_helper"

describe "When given an array of locations ethereum addresses" do
  it "can find the details for each location" do
    create_list(:location, 3)
    ethereum_addresses = Location.pluck(:ethereum_address) 
    get "/api/v1/get_locations_for_good_path", params: {locations: ethereum_addresses}

    actual_locations = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(actual_locations[0]).to have_key("street_address")
    expect(actual_locations[0]).to have_key("state")
    expect(actual_locations[0]).to have_key("country")
    expect(actual_locations[0]).to have_key("ethereum_address")
    expect(actual_locations[0]).to have_key("lat")
    expect(actual_locations[0]).to have_key("lng")
    expect(actual_locations[0]["creator"]).to eq Location.first.creator
    expect(actual_locations[0]["city"]).to eq Location.first.city
    expect(actual_locations[1]["creator"]).to eq Location.second.creator
    expect(actual_locations[1]["city"]).to eq Location.second.city
    expect(actual_locations[2]["creator"]).to eq Location.third.creator
    expect(actual_locations[2]["city"]).to eq Location.third.city
  end

  it "returns a 400 and invalid addresses if any ethereum addresses are invalid" do
    create_list(:location, 3)
    invalid_address = '0x000000007752b54713f15093d35f6cef2ad02c5c'
    ethereum_addresses = Location.pluck(:ethereum_address).push(invalid_address)

    get "/api/v1/get_locations_for_good_path", params: {locations: ethereum_addresses}
    
    expect(response.status).to eq 400
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:message]).to eq "Invalid address(es)"
    expect(body[:invalid_addresses]).to include(invalid_address)
  end
end
