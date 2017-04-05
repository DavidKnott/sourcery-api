class CreateLocation < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.text :creator
      t.text :physical_address
      t.text :city
      t.text :state
      t.text :country
      t.text :ethereum_address
      t.timestamps null: false
    end
  end
end
