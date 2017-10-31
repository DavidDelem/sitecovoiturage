class AddColumnToCovoiturage < ActiveRecord::Migration[5.1]
  def change
    add_column :covoiturages, :trajet_id, :integer
    add_column :covoiturages, :member_id, :integer
    add_column :covoiturages, :nb_places, :integer
  end
end
