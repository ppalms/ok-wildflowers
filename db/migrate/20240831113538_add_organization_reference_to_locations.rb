class AddOrganizationReferenceToLocations < ActiveRecord::Migration[7.1]
  def change
    add_reference :locations, :organization, null: false, foreign_key: true, default: @organization_id
  end

  reversible do |dir|
    dir.up do
      execute("UPDATE locations SET organization_id = #{@organization_id}")
    end
  end
end
