class Location < ApplicationRecord
  validates_presence_of :creator, :physical_address, :city, :state, :country, :ethereum_address
end