class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :completition
      t.float   :quantity
      t.float   :unit_price
      t.timestamps
    end
  end
end
