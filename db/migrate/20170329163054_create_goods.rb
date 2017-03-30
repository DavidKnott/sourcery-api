class CreateGoods < ActiveRecord::Migration[5.0]
  def change
    create_table :goods do |t|
      t.text :name
      t.text :description
      t.timestamps null: false
    end
  end
end
