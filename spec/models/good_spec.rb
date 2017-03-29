require 'rails_helper'

describe Good do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name)}
    it { is_expected.to validate_presence_of(:description)}
  end
end