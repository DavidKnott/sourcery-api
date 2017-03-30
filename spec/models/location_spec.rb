require 'rails_helper'

describe Location do
  context "validations" do
    it { is_expected.to validate_presence_of(:creator)}
    it { is_expected.to validate_presence_of(:physical_address)}
    it { is_expected.to validate_presence_of(:city)}
    it { is_expected.to validate_presence_of(:state)}
    it { is_expected.to validate_presence_of(:country)}
    it { is_expected.to validate_presence_of(:ethereum_address)}
  end
end