class ChangeProductHistoryToPrice < ActiveRecord::Migration
  def up
    rename_table :product_histories, :prices
    drop_table :sale_histories
  end

  def down
    rename_table :prices, :product_histories
  end
end
