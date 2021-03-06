class CreateSaleInvoices < ActiveRecord::Migration
  def change
    create_table :sale_invoices do |t|
      t.datetime :date
      t.string :invoice_type
      t.string :number
      t.float :iva
      t.float :subtotal
      t.float :total
      t.float :retencion, default: 0
      t.float :other_concepts, default: 0
      t.integer :firm_id
      t.integer :monthly_movement_id

      t.timestamps
    end
    add_index :sale_invoices, :firm_id
    add_index :sale_invoices, :monthly_movement_id
  end
end
