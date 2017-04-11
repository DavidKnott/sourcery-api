class CreateLots < ActiveRecord::Migration[5.0]
  def change
    create_table :lots do |t|
      t.string :uid
      t.references :product, foreign_key: true
      t.timestamps
    end

    add_index :lots, :uid
  end
end
