class MonthlyMovement < ActiveRecord::Base
  has_paper_trail

  STATUSES = ['Iniciado', 'Enviado', 'Finalizado']
  MONTHS = { Enero: 1, Febrero: 2, Marzo: 3, Abril: 4, Mayo: 5, Junio: 6, Julio: 7, Agosto: 8, Septiembre: 9, Octubre: 10, Noviembre: 11, Diciembre: 12 }

  belongs_to :user

  has_many :purchase_invoices

  attr_accessible :month, :year, :user_id, :status, :purchases_total, :purchases_iva_total, :purchases_otros_conc_total, :purchases_subtotal, :sales_total, :sales_iva_total, :sales_otros_conc_total, :sales_subtotal

  validates_presence_of :month, :year, :user_id, :status

  def self.months_for_select
    MONTHS.each_key.map { |key| key.to_s }
  end

  def started?
    status == STATUSES[0]
  end

end
