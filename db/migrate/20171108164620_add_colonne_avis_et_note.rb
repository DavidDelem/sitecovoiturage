class AddColonneAvisEtNote < ActiveRecord::Migration[5.1]
  def change
    add_column :covoiturages, :note, :int
    add_column :covoiturages, :avis, :string
  end
end
