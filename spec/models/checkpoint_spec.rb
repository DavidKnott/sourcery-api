require 'rails_helper'

describe Checkpoint do
  context 'database' do
    it { is_expected.to have_db_column(:id) }
    it { is_expected.to have_db_column(:creator) }
    it { is_expected.to have_db_column(:street_address) }
    it { is_expected.to have_db_column(:city) }
    it { is_expected.to have_db_column(:state) }
    it { is_expected.to have_db_column(:country) }
    it { is_expected.to have_db_column(:ethereum_address) }
    it { is_expected.to have_db_column(:lat) }
    it { is_expected.to have_db_column(:lng) }
    it { is_expected.to have_db_column(:zipcode) }
  end

  context "validations" do
    it { is_expected.to validate_uniqueness_of(:ethereum_address) }
    it { is_expected.to validate_length_of(:ethereum_address).is_at_least(42).is_at_most(42) }
    it { is_expected.to validate_presence_of(:creator) }
    it { is_expected.to validate_presence_of(:street_address) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:lat) }
    it { is_expected.to validate_presence_of(:lng) }
    it { is_expected.to validate_presence_of(:zipcode) }
  end

  describe 'ethereum_address' do
    let(:checkpoint) { Checkpoint.new }
    let(:bad_start_checkpoint) { '1x1234567890123456789012345678901234567890' }
    let(:bad_chars_checkpoint) { '0x?????67890123456789012345678901234567890' }
    let(:last_40) { SecureRandom.hex(20) }

    it 'is generated upon save' do
      checkpoint.save
      expect(checkpoint.ethereum_address.length).to eq 42
    end

    context 'validations' do
      it "is invalid when it does not start with '0x'" do
        checkpoint.ethereum_address = bad_start_checkpoint
        expect(checkpoint).not_to be_valid
      end

      it "is invalid when it uses anything other than hexadecimal characters" do
        checkpoint.ethereum_address = bad_chars_checkpoint
        expect(checkpoint).not_to be_valid
      end

      it "is valid when well formed" do
        valid_checkpoint = create(:checkpoint)

        expect(valid_checkpoint).to be_valid
      end
    end
  end

  describe ".get_details_for" do
    it "can get return a list of checkpoints given an array of ethereum_addresses" do
      create_list(:checkpoint, 3)
      
      ethereum_addresses = Checkpoint.pluck(:ethereum_address)
      actual_checkpoints = Checkpoint.get_details_for(ethereum_addresses)

      expect(actual_checkpoints[0].creator).to eq Checkpoint.first.creator
      expect(actual_checkpoints[0].city).to eq Checkpoint.first.city
      expect(actual_checkpoints[1].creator).to eq Checkpoint.second.creator
      expect(actual_checkpoints[1].city).to eq Checkpoint.second.city
      expect(actual_checkpoints[2].creator).to eq Checkpoint.third.creator
      expect(actual_checkpoints[2].city).to eq Checkpoint.third.city
    end
  end

  describe ".all_ethereum_addresses_valid?" do
    it "can return false if any of the given ethereum_addresses are invalid" do
      create_list(:checkpoint, 3)
      invalid_address = '0x000000007752b54713f15093d35f6cef2ad02c5c'

      ethereum_addresses = Checkpoint.pluck(:ethereum_address).push(invalid_address)
      invalid_checkpoints = Checkpoint.get_details_for(ethereum_addresses)

      expect(invalid_checkpoints).to eq false
    end
  end

  describe ".invalid_addresses" do
    it "returns an array of invalid addresses" do
      create_list(:checkpoint, 3)
      invalid_address  = '0x000000007752b54713f15093d35f6cef2ad02c5c'
      invalid_address2 = '0x00000000bad2b54713f15093d35f6cef2ad02c5c'
      
      addresses = Checkpoint.pluck(:ethereum_address) + [invalid_address, invalid_address2]
      invalid_addresses = Checkpoint.invalid_addresses(addresses)

      expect(invalid_addresses).to eq [invalid_address, invalid_address2]
    end
  end
end
