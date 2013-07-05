class MonthlyMovement < ActiveRecord::Base
  has_paper_trail

  STATUSES = ['Iniciado', 'Enviado', 'Finalizado']
  MONTHS = { Enero: 1, Febrero: 2, Marzo: 3, Abril: 4, Mayo: 5, Junio: 6, Julio: 7, Agosto: 8, Septiembre: 9, Octubre: 10, Noviembre: 11, Diciembre: 12 }

  belongs_to :user

  has_many :purchase_invoices
  has_many :sale_invoices

  attr_accessible :month, :year, :user_id, :status, :purchases_total, :purchases_iva_total, :purchases_otros_conc_total, :purchases_subtotal, :sales_total, :sales_iva_total, :sales_otros_conc_total, :sales_subtotal

  validates_presence_of :month, :year, :user_id, :status

  def self.months_for_select
    MONTHS.each_key.map { |key| key.to_s }
  end

  def started?
    status == STATUSES[0]
  end

  def send?
    status == STATUSES[1]
  end

  def set_as_send
    p_subtotal = self.purchase_invoices.sum(&:subtotal)
    p_iva_total = self.purchase_invoices.sum(&:iva)
    p_other = self.purchase_invoices.sum(&:other_concepts) + self.purchase_invoices.sum(&:retencion)
    p_total = self.purchase_invoices.sum(&:total)
    s_subtotal = self.sale_invoices.sum(&:subtotal)
    s_iva_total = self.sale_invoices.sum(&:iva)
    s_other = self.sale_invoices.sum(&:other_concepts) + self.sale_invoices.sum(&:retencion)
    s_total = self.sale_invoices.sum(&:total)
    self.update_attributes(status: STATUSES[1],
                                        purchases_subtotal: p_subtotal, purchases_iva_total: p_iva_total, purchases_otros_conc_total: p_other, purchases_total: p_total,
                                        sales_subtotal: s_subtotal, sales_iva_total: s_iva_total, sales_otros_conc_total: s_other, sales_total: s_total)
  end

  def set_as_finalized
    self.update_attributes(status: STATUSES[2])
  end
end
