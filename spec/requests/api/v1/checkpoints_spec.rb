require 'rails_helper'

describe "Checkpoints API" do
  it "can create a checkpoint" do
    post "/api/v1/checkpoints", params: { 
      checkpoint: { 
        creator: "John", 
        street_address: "Cr 70C No. 4-42 OF 203, Medellín", 
        city: "Medellín", 
        state: "Medellín", 
        country: "Colombia", 
        zipcode: "050022",
        lat: 6.27053,
        lng: -75.57211999999998
      }
    }

    response_checkpoint = JSON.parse(response.body)

    expect(response.status).to eq 201
    expect(response_checkpoint).to have_key 'creator'
    expect(response_checkpoint).to have_key 'street_address'
    expect(response_checkpoint).to have_key 'city'
    expect(response_checkpoint).to have_key 'state'
    expect(response_checkpoint).to have_key 'country'
    expect(response_checkpoint).to have_key 'zipcode'
    expect(response_checkpoint).to have_key 'lat'
    expect(response_checkpoint).to have_key 'lng'
    expect(response_checkpoint).to have_key 'ethereum_address'

    expect(response_checkpoint['creator']).to eq "John"
    expect(response_checkpoint['country']).to eq "Colombia"
    expect(response_checkpoint['zipcode']).to eq "050022"
    expect(response_checkpoint['lat']).to eq "6.27053"
    expect(Checkpoint.first.creator).to eq "John"
    expect(Checkpoint.first.street_address).to eq "Cr 70C No. 4-42 OF 203, Medellín"
    expect(Checkpoint.first.lat).to eq 6.27053
    expect(Checkpoint.first.ethereum_address).not_to be_nil 
  end

  it "can return a checkpoint given its address" do
    expected_checkpoint = create(:checkpoint)

    get "/api/v1/checkpoints/#{expected_checkpoint.ethereum_address}"

    actual_checkpoint = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(actual_checkpoint["creator"]).to eq Checkpoint.last.creator
    expect(actual_checkpoint["street_address"]).to eq Checkpoint.last.street_address
    expect(actual_checkpoint["ethereum_address"]).to eq Checkpoint.last.ethereum_address
  end

  context "Sad paths" do
    describe "If I forget a required field like 'creator' in the post form" do
      it "I get a 400 for a bad request" do
        post "/api/v1/checkpoints", params: { 
          checkpoint: { 
            street_address: "Cr 70C No. 4-42 OF 203, Medellín", 
            city: "Medellín", 
            state: "Medellín", 
            country: "Colombia", 
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
        create(:checkpoint)
        bad_address = 0x7da0bad4ffc79d7a69afdecb7b1eb0d767b37803

        get "/api/v1/checkpoints/#{bad_address}"

        expect(response.status).to eq 404
      end
    end
  end
end
