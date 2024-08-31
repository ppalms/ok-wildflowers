class CreatePlants < ActiveRecord::Migration[7.1]
  def change
    create_table :plants do |t|
      t.string :common_name, null: false, index: true
      t.string :other_common_names, array: true, default: []
      t.string :scientific_name

      t.timestamps
    end
  end
end
