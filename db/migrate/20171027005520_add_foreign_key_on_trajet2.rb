class AddForeignKeyOnTrajet2 < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :trajets, :members
  end
end
