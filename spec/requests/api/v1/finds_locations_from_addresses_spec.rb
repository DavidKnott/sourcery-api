require "rails_helper"

describe "When given an array of locations ethereum addresses" do
  it "can find the details for each location" do
    expected_location1 = create(:location, creator: "Ethan", city: "Denver", ethereum_address: '0x7da07904ffc79d7a69afdecb7b1eb0d767b37803')
    expected_location2 = create(:location, creator: "Mike", city: "New York", ethereum_address: '0x3de0d3f530d48edaca9961109956780975b09a56')
    expected_location3 = create(:location, creator: "Nick", city: "Boulder", ethereum_address: '0x267949f57752b54713f15093d35f6cef2ad02c5c')
    
    get "/api/v1/get_locations_for_good_path", params: {locations: ['0x7da07904ffc79d7a69afdecb7b1eb0d767b37803', '0x3de0d3f530d48edaca9961109956780975b09a56', '0x267949f57752b54713f15093d35f6cef2ad02c5c']}

    actual_locations = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(actual_locations[0]).to have_key("physical_address")
    expect(actual_locations[0]).to have_key("state")
    expect(actual_locations[0]).to have_key("country")
    expect(actual_locations[0]).to have_key("ethereum_address")
    expect(actual_locations[0]["creator"]).to eq "Ethan"
    expect(actual_locations[0]["city"]).to eq "Denver"
    expect(actual_locations[1]["creator"]).to eq "Mike"
    expect(actual_locations[1]["city"]).to eq "New York"
    expect(actual_locations[2]["creator"]).to eq "Nick"
    expect(actual_locations[2]["city"]).to eq "Boulder"
  end
end