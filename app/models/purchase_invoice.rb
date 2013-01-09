class PurchaseInvoice < ActiveRecord::Base
  has_paper_trail

  belongs_to :firm

  attr_accessible :date, :invoice_type, :destination_type, :retencion, :other_concepts, :iva, :subtotal, :total, :firm_id

  validates_presence_of :date, :invoice_type, :destination_type, :iva, :subtotal, :total, :firm_id

end
