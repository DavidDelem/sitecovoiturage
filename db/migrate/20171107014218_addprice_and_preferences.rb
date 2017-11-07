class AddpriceAndPreferences < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :preference_discussion, :integer
    add_column :members, :preference_cigarette, :integer
    add_column :members, :preference_animaux, :integer
    add_column :members, :preference_musique, :integer
    add_column :trajets, :prix, :float
    add_column :trajets, :dimension_valise, :integer
  end
end
