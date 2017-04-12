class Product < ApplicationRecord
  validates_presence_of :name, :description
  has_many :lots
end
