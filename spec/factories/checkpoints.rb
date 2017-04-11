FactoryGirl.define do
  factory :checkpoint do
    creator          { Faker::Name.first_name }
    street_address   { Faker::Address.street_address}
    city             { Faker::Address.city }
    state            { Faker::Address.state }
    zipcode          { Faker::Address.zip_code }
    lat              { Faker::Address.latitude }
    lng              { Faker::Address.longitude }
    country          { Faker::Address.country }
    ethereum_address { Faker::Crypto.sha256 }
  end
end
