class ChangePhysicalAddressToStreetAddress < ActiveRecord::Migration[5.0]
  def change
    rename_column :locations, :physical_address, :street_address
  end
end
