require 'rails_helper'

describe "Locations API" do
  it "can create a location" do
    post "/api/v1/locations", params: { location: { creator: "John", physical_address: "Cr 70C No. 4-42 OF 203, Medellín", city: "Medellín", state: "Medellín", country: "Colombia", ethereum_address: "0x7da07904ffc79d7a69afdecb7b1eb0d767b37803"}}

    expect(response.status).to eq 201
    expect(Location.first.creator).to eq "John"
    expect(Location.first.physical_address).to eq "Cr 70C No. 4-42 OF 203, Medellín"
    expect(Location.first.ethereum_address).to eq "0x7da07904ffc79d7a69afdecb7b1eb0d767b37803"
  end

  it "can return a location given its address" do
    expected_location = create(:location, creator: "John", physical_address: "Cr 70C No. 4-42 OF 203, Medellín", ethereum_address: "0x7da07904ffc79d7a69afdecb7b1eb0d767b37803")
    get "/api/v1/locations/#{expected_location.ethereum_address}"

    actual_location = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(actual_location["creator"]).to eq "John"
    expect(actual_location["physical_address"]).to eq "Cr 70C No. 4-42 OF 203, Medellín"
    expect(actual_location["ethereum_address"]).to eq "0x7da07904ffc79d7a69afdecb7b1eb0d767b37803"
  end
end