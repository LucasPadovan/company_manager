class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :area
      t.text :details
      t.integer :firm_id

      t.timestamps
    end
    add_index :contacts, :firm_id
  end
end
