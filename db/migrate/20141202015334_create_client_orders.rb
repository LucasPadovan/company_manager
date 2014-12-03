class CreateClientOrders < ActiveRecord::Migration
  def change
    create_table :client_orders do |t|
      t.datetime  :completed
      t.datetime  :received
      t.datetime  :cancelled
      t.integer   :firm_id
      t.integer   :deliver_in
      t.integer   :number, null: false
      t.integer   :user_id
      t.string    :external_code
      t.string    :place
      t.string    :status
      t.text      :details

      t.timestamps
    end
    add_index :client_orders, :number
  end
end
