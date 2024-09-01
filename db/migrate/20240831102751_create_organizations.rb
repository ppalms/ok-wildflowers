class CreateOrganizations < ActiveRecord::Migration[7.1]
  def change
    create_table :organizations do |t|
      t.string :name, null: false

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Organization.create(name: 'PlantHQ')
        @organization_id = Organization.first.id
      end
    end
  end
end
