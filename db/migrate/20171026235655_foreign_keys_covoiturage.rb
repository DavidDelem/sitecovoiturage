class ForeignKeysCovoiturage < ActiveRecord::Migration[5.1]
  def change
    change_column :covoiturages, :trajet_id, :integer, :limit => 8
    change_column :covoiturages, :member_id, :integer, :limit => 8
    add_foreign_key :covoiturages, :trajets
    add_foreign_key :covoiturages, :members
  end
end
