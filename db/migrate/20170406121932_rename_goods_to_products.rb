class RenameGoodsToProducts < ActiveRecord::Migration[5.0]
  def change
    rename_table :goods, :products
  end
end
