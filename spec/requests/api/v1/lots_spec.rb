require 'rails_helper'

describe "Lots API" do
  let!(:product) { create(:product) }

  it "can create a lot" do
    expect { 
      post "/api/v1/lots", params: {
        lot: {
          product_id: Product.first.id
        }
      }
    }.to change {Lot.count}.by 1

    lot = JSON.parse(response.body)

    expect(response.status).to eq 201
    expect(lot['id']).to be_an Integer
  end

  context "sad path" do
    it "does not create a lot when product does not exist" do
      nonexistent_product_id = 999

      post "/api/v1/lots", params: {
        lot: {
          product_id: nonexistent_product_id
        }
      }

      expect(response.status).to eq 400
    end
  end
end
