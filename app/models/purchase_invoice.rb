class PurchaseInvoice < ActiveRecord::Base
  #todo: unir en Inovice solo, los datos van a ser los mismos pero van a variar cuando se generen, los modelos de purchaseInvoice van a agregar los datos nuestros al emisor y de la empresa objetivo como receptor
  #      los modelos de saleInovice van a autocompletar con los datos del vendedor en el emisor y nosotros como receptor,
  #      pero siempre se debe poder editar el receptor.
  #      Si se generara una saleInovoice de la nada, deberia poder crear invoiceItem, que generaría un pedido, un remito y los marcaria como "generados por factura"
  #      para controlar que esto esta pasando y analizarlo, los invoiceItem corresponden con los deliverItem o los orderItem (solo items en este caso).
  #      Si se generara la factura a partir de un remito o de una orden de pedido, deberia generar todos los invoiceItem a partir del remito o la orden, segun corresponda.
  #      Al hacer esto, podria generar el remito y marcarlo como entregado si es que no estaba en este estado ya.

  #todo: poner en default los valores en base de datos para poder calcular rápido.
  has_paper_trail

  belongs_to :firm
  belongs_to :monthly_movement

  attr_accessible :date, :invoice_type, :destination_type, :retencion, :other_concepts, :iva, :subtotal, :total, :firm_id, :monthly_movement_id, :number

  validates_presence_of :date, :invoice_type, :destination_type, :iva, :subtotal, :total, :firm_id, :monthly_movement_id

  def to_csv
    [date.strftime('%d/%m/%y'), number, firm.nombre, firm.cuit, (destination_type == 'Ventas' ? subtotal : 0 ), (destination_type == 'Consumo' ? subtotal : 0 ), iva, retencion, other_concepts, total].to_csv
  end

end
