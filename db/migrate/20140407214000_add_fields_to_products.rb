class AddFieldsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :type, :string
    add_column :products, :unit, :string
    add_column :products, :initial_stock, :decimal
    add_column :products, :stock, :decimal
  end
end
