require "rails_helper"

describe "Products API" do
  it "can create a product" do
    post "/api/v1/products", params: { 
      product: { 
        name: "cool coffee", 
        description: "A delicous coffee from Colombia."
      }
    }

    expect(response.status).to eq 201
    expect(Product.first.name).to eq "cool coffee"
    expect(Product.first.description).to eq "A delicous coffee from Colombia."
  end

  it "can return a product given its id" do
    product = create(:product)

    get "/api/v1/products/#{product.id}"

    actual_good = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(actual_good["name"]).to eq Product.last.name
    expect(actual_good["description"]).to eq Product.last.description
  end

  context "Sad paths" do
    describe "If I fail to include a required param, like name" do
      it "I get a 400" do
        post "/api/v1/products", params: { 
          product: { 
            description: "A delicous coffee from Colombia."
          }
        }

        expect(response.status).to eq 400
      end
    end

    describe "and if I search for a non existent id" do
      it "I get a 404" do
        create(:product)

        get "/api/v1/products/#{Product.last.id + 1}"

        expect(response.status).to eq 404
      end
    end
  end
end
