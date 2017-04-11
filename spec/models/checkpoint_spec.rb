require 'rails_helper'

describe Checkpoint do
  context "validations" do
    it { is_expected.to validate_presence_of(:creator) }
    it { is_expected.to validate_presence_of(:street_address) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:ethereum_address) }
    it { is_expected.to validate_presence_of(:lat) }
    it { is_expected.to validate_presence_of(:lng) }
    it { is_expected.to validate_presence_of(:zipcode) }
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
