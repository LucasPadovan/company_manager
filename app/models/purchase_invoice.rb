class PurchaseInvoice < ActiveRecord::Base
  has_paper_trail

  belongs_to :firm
  belongs_to :monthly_movement

  attr_accessible :date, :invoice_type, :destination_type, :retencion, :other_concepts, :iva, :subtotal, :total, :firm_id, :monthly_movement_id

  validates_presence_of :date, :invoice_type, :destination_type, :iva, :subtotal, :total, :firm_id, :monthly_movement_id

  def to_csv
    [date, firm.nombre, firm.cuit, (destination_type == 'Ventas' ? subtotal : 0 ), (destination_type == 'Consumo' ? subtotal : 0 ), iva, retencion, other_concepts, total].to_csv
  end

end
