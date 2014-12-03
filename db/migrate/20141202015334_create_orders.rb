class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
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
    add_index :orders, :number
  end
end
