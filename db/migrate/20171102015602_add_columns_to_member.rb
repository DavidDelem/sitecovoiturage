class AddColumnsToMember < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :nom, :string
    add_column :members, :prenom, :string
    add_column :members, :presentation, :string
    add_column :members, :vehicule_type, :string
    add_column :members, :vehicule_annee, :string
  end
end
