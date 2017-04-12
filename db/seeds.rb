Lot.destroy_all
Product.destroy_all
Checkpoint.destroy_all

10.times do
  FactoryGirl.create(:product)
  FactoryGirl.create(:checkpoint)
  5.times { FactoryGirl.create(:lot, product: Product.all.sample) }
end

FactoryGirl.create(:checkpoint, ethereum_address: '0x4a48d76b56f16fe9200bcc6a7fc8e85cf8e4f7b1')
FactoryGirl.create(:checkpoint, ethereum_address: '0x4a48d76b56f16fe9200bcc6a7fc8e85cf8e4f7b2')
FactoryGirl.create(:checkpoint, ethereum_address: '0x4a48d76b56f16fe9200bcc6a7fc8e85cf8e4f7b3')

