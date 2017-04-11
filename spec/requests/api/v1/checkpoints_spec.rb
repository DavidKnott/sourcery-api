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
        ethereum_address: "0x7da07904ffc79d7a69afdecb7b1eb0d767b37803",
        zipcode: "050022",
        lat: 6.27053,
        lng: -75.57211999999998
      }
    }

    expect(response.status).to eq 201
    expect(Checkpoint.first.creator).to eq "John"
    expect(Checkpoint.first.street_address).to eq "Cr 70C No. 4-42 OF 203, Medellín"
    expect(Checkpoint.first.ethereum_address).to eq "0x7da07904ffc79d7a69afdecb7b1eb0d767b37803"
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
        create(:checkpoint)
        bad_address = 0x7da0bad4ffc79d7a69afdecb7b1eb0d767b37803

        get "/api/v1/checkpoints/#{bad_address}"

        expect(response.status).to eq 404
      end
    end
  end
end
