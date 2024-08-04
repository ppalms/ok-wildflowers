class AddCommonNamesToPlants < ActiveRecord::Migration[7.1]
  def change
    add_column :plants, :common_names, :string, array: true, default: []
  end
end
