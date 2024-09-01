class CreateOrganizations < ActiveRecord::Migration[7.1]
  def change
    create_table :organizations do |t|
      t.string :name, null: false

      t.timestamps

      reversible do |dir|
        dir.up do
          Organization.create(name: 'PlantHQ')
        end
      end
    end
  end
end
