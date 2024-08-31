class AddOrganizationReferenceToLocations < ActiveRecord::Migration[7.1]
  def change
    add_reference :locations, :organization, null: false, foreign_key: true
  end
end
