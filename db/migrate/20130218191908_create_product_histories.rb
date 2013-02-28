class CreateProductHistories < ActiveRecord::Migration
  def change
    create_table :product_histories do |t|
      t.float :purchase_price
      t.float :sale_price
      t.integer :product_id
      t.integer :user_id
      t.integer :firm_id
      t.datetime :date

      t.timestamps
    end
  end
end
