class AddNumberToPurchaseInvoice < ActiveRecord::Migration
  def up
    add_column :purchase_invoices, :number, :string
  end

  def down
    remove_column :purchase_invoices, :number
  end
end
