class Component < ActiveRecord::Base
  belongs_to :product
  belongs_to :recipe

  attr_accessible :unit, :quantity, :product_id, :recipe_id

  validates_presence_of :quantity, :product_id, :recipe_id

  def lowest_cost
    product.lowest_price_and_firm
  end

  def highest_cost
    product.highest_price_and_firm
  end
end
