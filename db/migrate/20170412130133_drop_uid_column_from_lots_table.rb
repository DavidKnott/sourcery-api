class DropUidColumnFromLotsTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :lots, :uid, :string
  end
end
