class Firm < ActiveRecord::Base
  has_paper_trail

  has_many :contacts
  has_many :purchase_invoices
  has_many :sale_invoices
  has_many :purchase_interests
  has_many :sale_interests
  has_many :products, through: :interests

  attr_accessible :nombre, :cuit, :afip_cond

  validates_presence_of :nombre, :cuit, :afip_cond

  def self.firms_for_select
    Firm.all.map{ |x| ["#{x.nombre} - #{x.cuit}", x.id]}
  end

  def to_s
    nombre
  end
end
