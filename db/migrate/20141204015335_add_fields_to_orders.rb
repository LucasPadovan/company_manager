class AddFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :requester,      :string
    add_column :orders, :requester_area, :string
  end
end
