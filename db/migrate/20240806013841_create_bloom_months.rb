class CreateBloomMonths < ActiveRecord::Migration[7.1]
  def change
    create_table :bloom_months do |t|
      t.string :month_name
      t.integer :month_number

      t.timestamps
    end
    add_index :bloom_months, :month_number
  end
end
