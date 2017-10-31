class CreateCovoiturages < ActiveRecord::Migration[5.1]
  def change
    create_table :covoiturages do |t|

      t.timestamps
    end
  end
end
