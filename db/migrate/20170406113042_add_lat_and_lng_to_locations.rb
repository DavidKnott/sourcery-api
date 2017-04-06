class AddLatAndLngToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :lat, :decimal
    add_column :locations, :lng, :decimal
    add_column :locations, :zipcode, :integer
  end
end
