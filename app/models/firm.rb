class Firm < ActiveRecord::Base
  has_paper_trail

  has_many :contacts
  has_many :purchase_invoices
  has_many :sale_invoices
  has_many :sale_histories
  has_many :product_histories

  attr_accessible :nombre, :cuit, :afip_cond

  validates_presence_of :nombre, :cuit, :afip_cond

end
