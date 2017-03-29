require "rails_helper"

describe "Goods API" do
  it "can create a good" do
    post "/api/v1/goods", params: { good: { name: "cool coffee", description: "A delicous coffee from Colombia."}}

    expect(response.status).to eq 201
    expect(Good.first.name).to eq "cool coffee"
    expect(Good.first.description).to eq "A delicous coffee from Colombia."
  end

  it "can retun return a good given it's name" do
    expected_good = create(:good, name: "cool coffee", description: "A delicous coffee from Colombia.")
    get "/api/v1/goods/#{expected_good.id}"

    actual_good = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(actual_good.name).to eq "cool coffee"
    expect(actual_good.description).to eq "A delicous coffee from Colombia."
  end
end