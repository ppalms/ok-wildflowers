class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.text :content

      t.timestamps
    end

    add_reference :notes, :location, foreign_key: true
  end
end
