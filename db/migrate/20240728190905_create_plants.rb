class CreatePlants < ActiveRecord::Migration[7.1]
  def change
    create_table :plants do |t|
      t.string :scientific_name
      t.text :common_names, array: true
      t.text :bloom_time, array: true
      t.text :bloom_colors, array: true

      t.timestamps
    end
  end
end
