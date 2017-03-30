require 'rails_helper'

describe "Locatins API" do
  it "can create a location" do
    post "/api/v1/locations", params: { location: { creator: "John", physical_address: "Cr 70C No. 4-42 OF 203, Medellín", city: "Medellín", state: "Medellín", country: "Colombia", ethereum_address: "0x7da07904ffc79d7a69afdecb7b1eb0d767b37803"}}

    expect(response.status).to eq 201
    expect(Location.first.creator).to eq "John"
    expect(Location.first.physical_address).to eq "Cr 70C No. 4-42 OF 203, Medellín"
    expect(Location.first.ethereum_address).to eq "0x7da07904ffc79d7a69afdecb7b1eb0d767b37803"
  end
end