class CreateComponents < ActiveRecord::Migration
  def up
    create_table(:components) do |t|
      t.integer :custom_product_id
      t.integer :product_id
    end
    add_index :components, [:custom_product_id, :product_id]
  end

  def down
    drop_table :components
  end
end
