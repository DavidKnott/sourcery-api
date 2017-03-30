require "rails_helper"

describe "Goods API" do
  it "can create a good" do
    post "/api/v1/goods", params: { good: { name: "cool coffee", description: "A delicous coffee from Colombia."}}

    expect(response.status).to eq 201
    expect(Good.first.name).to eq "cool coffee"
    expect(Good.first.description).to eq "A delicous coffee from Colombia."
  end
end