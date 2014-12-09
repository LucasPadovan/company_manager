class CreateDelivers < ActiveRecord::Migration
  def change
    create_table :delivers do |t|
      t.integer  :item_id
      t.integer  :receipt_id
      t.float    :quantity
      t.datetime :delivered_at
      t.timestamps
    end
    change_column :items, :completition, :integer, default: 0
  end
end
