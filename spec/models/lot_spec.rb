require 'rails_helper'

describe Lot do
  context 'database' do
    it { is_expected.to have_db_column(:id) }
    it { is_expected.to have_db_column(:uid) }
    it { is_expected.to have_db_column(:created_at) }
    it { is_expected.to have_db_column(:updated_at) }
  end

  context 'validations' do
    it { is_expected.to validate_uniqueness_of(:uid) }
    it { is_expected.to validate_length_of(:uid).is_at_least(42).is_at_most(42) }
  end

  context 'relationships' do
    it { is_expected.to belong_to(:product) }
  end

  describe 'uid' do
    let!(:product) { create(:product) }
    let!(:lot) { Lot.new(product: product) }
    let(:bad_start_uid) { '1x1234567890123456789012345678901234567890' }
    let(:bad_chars_uid) { '0x?????67890123456789012345678901234567890' }
    let(:last_40) { SecureRandom.hex(20) }

    it 'is generated upon save' do
      lot.save
      expect(lot.uid.length).to eq 42
    end

    context 'validations' do
      it "is invalid when it does not start with '0x'" do
        lot.uid = bad_start_uid
        expect(lot).not_to be_valid
      end

      it "is invalid when it uses anything other than hexadecimal characters" do
        lot.uid = bad_chars_uid
        expect(lot).not_to be_valid
      end

      it "is valid when well formed" do
        expect(lot).to be_valid
      end
    end
  end
end
