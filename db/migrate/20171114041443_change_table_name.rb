class ChangeTableName < ActiveRecord::Migration[5.1]
  def change
    rename_table :covoiturages, :reservations
  end
end