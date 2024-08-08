class RemoveCommonNamesFromPlant < ActiveRecord::Migration[7.1]
  def change
    remove_column :plants, :common_names, :string
  end
end
