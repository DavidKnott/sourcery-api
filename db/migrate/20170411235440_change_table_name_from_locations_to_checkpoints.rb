class ChangeTableNameFromLocationsToCheckpoints < ActiveRecord::Migration[5.0]
  def change
    rename_table :locations, :checkpoints
  end
end
