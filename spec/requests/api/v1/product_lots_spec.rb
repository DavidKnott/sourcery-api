require 'rails_helper'

describe "Product API relationships" do
  let!(:product_1) { create(:product, name: "coffee") }
  let!(:product_2) { create(:product, name: "bananas") }
  before do
    create_list(:lot, 3, product: product_1) 
    create_list(:lot, 4, product: product_2)
  end

  it "returns the lot ids" do
    product_2_id = Product.find_by(name: "bananas").id
    product_2_lot_ids = product_2.lots.pluck(:id)
    product_1_lot_ids = product_1.lots.pluck(:id)

    get "/api/v1/products/#{product_2_id}/lots"

    lots = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(lots).to be_an Array
    expect(lots.length).to eq 4
    lots.each do |lot_id|
      expect(product_2_lot_ids).to include(lot_id)
      expect(product_1_lot_ids).not_to include(lot_id)
    end
  end

  it "returns a 400 when given a nonexistent product id" do
    bad_product_id = 999

    get "/api/v1/products/#{bad_product_id}/lots"

    expect(response.status).to eq 400
  end
end
