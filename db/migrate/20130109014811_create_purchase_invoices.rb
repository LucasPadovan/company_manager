class CreatePurchaseInvoices < ActiveRecord::Migration
  def change
    create_table :purchase_invoices do |t|
      t.datetime :date
      t.string :invoice_type
      t.string :destination_type
      t.float :iva
      t.float :subtotal
      t.float :total
      t.float :retencion
      t.float :other_concepts
      t.integer :firm_id

      t.timestamps
    end
    add_index :purchase_invoices, :firm_id
  end
end
