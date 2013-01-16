class CreateMonthlyMovements < ActiveRecord::Migration
  def change
    create_table :monthly_movements do |t|
      t.string :month
      t.integer :year
      t.integer :user_id
      t.string :status
      t.float :purchases_total
      t.float :purchases_iva_total
      t.float :purchases_otros_conc_total
      t.float :purchases_subtotal
      t.float :sales_total
      t.float :sales_iva_total
      t.float :sales_otros_conc_total
      t.float :sales_subtotal

      t.timestamps
    end
  end
end
