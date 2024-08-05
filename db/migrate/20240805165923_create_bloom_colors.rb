class CreateBloomColors < ActiveRecord::Migration[7.1]
  def change
    create_table :bloom_colors do |t|
      t.string :name

      t.timestamps
    end
  end
end
