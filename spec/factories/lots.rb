FactoryGirl.define do
  factory :lot do
    uid { '0x' + SecureRandom.hex(20) }
    product
  end
end
