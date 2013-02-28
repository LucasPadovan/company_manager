class CreateSaleHistories < ActiveRecord::Migration
  def change
    create_table :sale_histories do |t|
      t.datetime :date
      t.float :price
      t.integer :product_id
      t.integer :firm_id

      t.timestamps
    end
  end
end
