Lot.destroy_all
Product.destroy_all
Checkpoint.destroy_all

10.times do
  FactoryBot.create(:product)
  FactoryBot.create(:checkpoint)
  5.times { FactoryBot.create(:lot, product: Product.all.sample) }
end

FactoryBot.create(:checkpoint, ethereum_address: '0x4a48d76b56f16fe9200bcc6a7fc8e85cf8e4f7b1')
FactoryBot.create(:checkpoint, ethereum_address: '0x4a48d76b56f16fe9200bcc6a7fc8e85cf8e4f7b2')
FactoryBot.create(:checkpoint, ethereum_address: '0x4a48d76b56f16fe9200bcc6a7fc8e85cf8e4f7b3')

