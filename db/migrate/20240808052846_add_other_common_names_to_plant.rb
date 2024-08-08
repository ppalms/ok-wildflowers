class AddOtherCommonNamesToPlant < ActiveRecord::Migration[7.1]
  def change
    add_column :plants, :other_common_names, :string, array: true, default: []
  end
end
