class Interest < ActiveRecord::Base
  belongs_to :product
  belongs_to :firm

  has_many :product_histories
  has_many :sale_histories

  attr_accessible :date, :product_id, :firm_id

  def price

  end

  def sale_price

  end

  def purchase_price

  end
end