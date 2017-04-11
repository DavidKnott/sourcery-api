# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all
Location.destroy_all

10.times do
  FactoryGirl.create(:product)
  FactoryGirl.create(:location)
end

FactoryGirl.create(:location, ethereum_address: '4a48d76b56f16fe9200bcc6a7fc8e85cf8e4f7b5488ff229209748345cb0f559')
FactoryGirl.create(:location, ethereum_address: '8dc5b8c7528b8846899dbd56e6ffbf7aeff97cbb8ffd611c7d56ea19b26bfbd0')
FactoryGirl.create(:location, ethereum_address: '03ca2072179b8dc420eb5a88e1f2a93f1d3cbc3087070c91869e437a8e15b09a')

