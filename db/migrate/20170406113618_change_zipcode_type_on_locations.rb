class ChangeZipcodeTypeOnLocations < ActiveRecord::Migration[5.0]
  def change
    change_column :locations, :zipcode, :string
  end
end
