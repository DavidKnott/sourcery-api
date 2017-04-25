require "rails_helper"

describe "When given an array of checkpoints ethereum addresses" do
  it "can find the details for each checkpoint" do
    create_list(:checkpoint, 3)
    ethereum_addresses = Checkpoint.pluck(:ethereum_address) 
    get "/api/v1/get_checkpoints_for_good_path", params: {checkpoints: ethereum_addresses}

    actual_checkpoints = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(actual_checkpoints[0]).to have_key("street_address")
    expect(actual_checkpoints[0]).to have_key("state")
    expect(actual_checkpoints[0]).to have_key("country")
    expect(actual_checkpoints[0]).to have_key("ethereum_address")
    expect(actual_checkpoints[0]).to have_key("lat")
    expect(actual_checkpoints[0]).to have_key("lng")
    expect(actual_checkpoints[0]["creator"]).to eq Checkpoint.first.creator
    expect(actual_checkpoints[0]["city"]).to eq Checkpoint.first.city
    expect(actual_checkpoints[1]["creator"]).to eq Checkpoint.second.creator
    expect(actual_checkpoints[1]["city"]).to eq Checkpoint.second.city
    expect(actual_checkpoints[2]["creator"]).to eq Checkpoint.third.creator
    expect(actual_checkpoints[2]["city"]).to eq Checkpoint.third.city
  end

  it "returns a 400 and invalid addresses if any ethereum addresses are invalid" do
    create_list(:checkpoint, 3)
    invalid_address = '0x000000007752b54713f15093d35f6cef2ad02c5c'
    ethereum_addresses = Checkpoint.pluck(:ethereum_address).push(invalid_address)

    get "/api/v1/get_checkpoints_for_good_path", params: {checkpoints: ethereum_addresses}
    
    expect(response.status).to eq 400
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:message]).to eq "Invalid address(es)"
    expect(body[:invalid_addresses]).to include(invalid_address)
  end

  it "returns a 400 and message if addresses is empty" do
    get "/api/v1/get_checkpoints_for_good_path", params: {checkpoints: []}
    
    expect(response.status).to eq 400
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:message]).to eq "No addresses sent"
  end
end
