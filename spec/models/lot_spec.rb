require 'rails_helper'

describe Lot do
  context 'database' do
    it { is_expected.to have_db_column(:id) }
    it { is_expected.to have_db_column(:created_at) }
    it { is_expected.to have_db_column(:updated_at) }
  end

  context 'relationships' do
    it { is_expected.to belong_to(:product) }
  end
end
