class CreateJoinTablePlantsBloomColors < ActiveRecord::Migration[7.1]
  def change
    create_join_table :plants, :bloom_colors do |t|
      # t.index [:plant_id, :bloom_color_id]
      # t.index [:bloom_color_id, :plant_id]
    end
  end
end
