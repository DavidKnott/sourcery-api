require 'rails_helper'

describe Product do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
  end

  context 'relationships' do
    it { is_expected.to have_many(:lots) }
  end

  context '.lot_ids' do
    let!(:product) { create(:product) }
    before { create_list(:lot, 3, product: product) }
    let!(:lot_ids) { product.lots.pluck(:id) }

    it "returns the lot ids for a given prouct" do
      expect(product.lot_ids).to match_array lot_ids
    end
  end
end
