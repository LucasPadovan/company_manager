class AddFieldsToComponents < ActiveRecord::Migration
  def change
    remove_index :components, [:custom_product_id, :product_id]
    remove_column :components, :custom_product_id
    add_column :components, :quantity, :float
    add_column :components, :unit, :string
    add_column :components, :recipe_id, :integer
  end
end
