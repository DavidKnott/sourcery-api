require 'rails_helper'

describe "Locations API" do
  it "can create a location" do
    post "/api/v1/locations", params: { 
      location: { 
        creator: "John", 
        street_address: "Cr 70C No. 4-42 OF 203, Medellín", 
        city: "Medellín", 
        state: "Medellín", 
        country: "Colombia", 
        ethereum_address: "0x7da07904ffc79d7a69afdecb7b1eb0d767b37803",
        zipcode: "050022",
        lat: 6.27053,
        lng: -75.57211999999998
      }
    }

    expect(response.status).to eq 201
    expect(Location.first.creator).to eq "John"
    expect(Location.first.street_address).to eq "Cr 70C No. 4-42 OF 203, Medellín"
    expect(Location.first.ethereum_address).to eq "0x7da07904ffc79d7a69afdecb7b1eb0d767b37803"
  end

  it "can return a location given its address" do
    expected_location = create(:location)

    get "/api/v1/locations/#{expected_location.ethereum_address}"

    actual_location = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(actual_location["creator"]).to eq Location.last.creator
    expect(actual_location["street_address"]).to eq Location.last.street_address
    expect(actual_location["ethereum_address"]).to eq Location.last.ethereum_address
  end

  context "Sad paths" do
    describe "If I forget a required field like 'creator' in the post form" do
      it "I get a 400 for a bad request" do
        post "/api/v1/locations", params: { 
          location: { 
            street_address: "Cr 70C No. 4-42 OF 203, Medellín", 
            city: "Medellín", 
            state: "Medellín", 
            country: "Colombia", 
            ethereum_address: "0x7da07904ffc79d7a69afdecb7b1eb0d767b37803",
            zipcode: "050022",
            lat: 6.27053,
            lng: -75.57211999999998
          }
        }

        expect(response.status).to eq 400
      end
    end

    describe "When I provide an invalid  ethereum_address" do
      it "I get a 404 for unfound record" do
        create(:location)
        bad_address = 0x7da0bad4ffc79d7a69afdecb7b1eb0d767b37803

        get "/api/v1/locations/#{bad_address}"

        expect(response.status).to eq 404
      end
    end
  end
end
