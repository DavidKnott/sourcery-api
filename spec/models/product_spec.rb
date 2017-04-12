require 'rails_helper'

describe Product do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
  end

  context 'relationships' do
    it { is_expected.to have_many(:lots) }
  end
end
