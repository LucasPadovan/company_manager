class CreateInterests < ActiveRecord::Migration
  def up
    create_table :interests do |t|
      t.integer :firm_id
      t.integer :product_id

      t.timestamps
    end
    add_index :interests, [:firm_id, :product_id]

    remove_column :product_histories, :firm_id
    remove_column :product_histories, :product_id
    remove_column :sale_histories, :firm_id
    remove_column :sale_histories, :product_id

    add_column :product_histories, :interest_id, :integer
    add_column :sale_histories, :interest_id, :integer
  end

  def down
    drop_table :interests

    remove_column :product_histories, :interest_id
    remove_column :sale_histories, :interest_id

    add_column :product_histories, :firm_id, :integer
    add_column :product_histories, :product_id, :integer
    add_column :sale_histories, :firm_id, :integer
    add_column :sale_histories, :product_id, :integer
  end
end
