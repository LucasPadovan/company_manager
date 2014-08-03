class Interest < ActiveRecord::Base
  #todo: validaciones, avisar al eliminar relaciones con precios, no dejar eliminar si alguien mas las esta usando
  belongs_to :product
  belongs_to :firm

  has_many :prices

  accepts_nested_attributes_for :prices

  attr_accessible :date, :product_id, :firm_id, :prices_attributes

  def is_purchase_interest?
    self.class == PurchaseInterest
  end
end
