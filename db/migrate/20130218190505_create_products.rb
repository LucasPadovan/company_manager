class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :rubro
      t.integer :user_id

      t.timestamps
    end
  end
end
