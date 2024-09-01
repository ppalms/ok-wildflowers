class AddOrganizationReferenceToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :organization, null: false, foreign_key: true, default: @organization_id
  end

  reversible do |dir|
    dir.up do
      execute("UPDATE users SET organization_id = #{@organization_id}")
    end
  end
end
