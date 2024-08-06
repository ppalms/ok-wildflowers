class CreateJoinTablePlantsBloomMonths < ActiveRecord::Migration[7.1]
  def change
    create_join_table :plants, :bloom_months do |t|
      # t.index [:plant_id, :bloom_month_id]
      # t.index [:bloom_month_id, :plant_id]
    end
  end
end
