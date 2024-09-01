class CreateOrganizations < ActiveRecord::Migration[7.1]
  def change
    create_table :organizations do |t|
      t.string :name, null: false

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        execute("INSERT INTO organizations (name, created_at, updated_at) VALUES ('PlantHQ', NOW(), NOW())")
      end
    end
  end
end
