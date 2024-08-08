class AddCommonNameToPlant < ActiveRecord::Migration[7.1]
  def change
    add_column :plants, :common_name, :string
    add_index :plants, :common_name
  end
end
