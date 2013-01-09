class CreateFirms < ActiveRecord::Migration
  def change
    create_table :firms do |t|
      t.string :nombre
      t.string :cuit
      t.string :afip_cond

      t.timestamps
    end
  end
end
