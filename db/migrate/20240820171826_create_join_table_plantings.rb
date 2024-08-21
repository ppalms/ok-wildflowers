class CreateJoinTablePlantings < ActiveRecord::Migration[7.1]
  def change
    create_join_table :locations, :plants, table_name: :plantings do |t|
      t.index [:location_id, :plant_id]
      t.index [:plant_id, :location_id]
    end
  end
end
