class Interest < ActiveRecord::Base
  #todo: validaciones, avisar al eliminar relaciones con precios, no dejar eliminar si alguien mas las esta usando
  #todo: PurchaseInterest y SaleInterest, es mas natural y puedo eliminar los product_histories y sale_histories, solo dejo de relacion algo parecido a price.
  belongs_to :product
  belongs_to :firm

  has_many :product_histories
  has_many :sale_histories

  accepts_nested_attributes_for :product_histories
  accepts_nested_attributes_for :sale_histories

  attr_accessible :date, :product_id, :firm_id, :product_histories_attributes, :sale_histories_attributes

  def price
    product_histories.last.purchase_price if product_histories.any?
  end

  def sale_price

  end

  def purchase_price

  end
end