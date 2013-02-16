class SaleInvoice < ActiveRecord::Base
  has_paper_trail

  belongs_to :firm
  belongs_to :monthly_movement

  attr_accessible :date, :invoice_type, :number, :iva, :subtotal, :total, :retencion, :other_concepts, :firm_id, :monthly_movement_id

  validates_presence_of :date, :invoice_type, :number, :iva, :subtotal, :total, :firm_id, :monthly_movement_id

  def to_csv
    [date, number, firm.nombre, firm.cuit, iva, subtotal, retencion, other_concepts, total].to_csv
  end

end
