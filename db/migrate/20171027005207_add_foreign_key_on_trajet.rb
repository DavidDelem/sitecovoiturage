class AddForeignKeyOnTrajet < ActiveRecord::Migration[5.1]
  def change
    add_column :trajets, :member_id, :integer, :limit => 8
  end
end
