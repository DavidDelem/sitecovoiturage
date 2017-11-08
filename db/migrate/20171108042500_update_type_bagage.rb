class UpdateTypeBagage < ActiveRecord::Migration[5.1]
  def change
    change_column :trajets, :dimension_valise, :string
  end
end
