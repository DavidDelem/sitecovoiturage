class CreateTrajets < ActiveRecord::Migration[5.1]
  def change
    create_table :trajets do |t|
      t.string :horaire_depart
      t.string :ville_depart
      t.string :ville_destination
      t.integer :nb_places_totales

      t.timestamps
    end
  end
end
