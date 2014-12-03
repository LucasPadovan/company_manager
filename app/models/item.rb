class Item < ActiveRecord::Base
  has_paper_trail

  belongs_to :order
  belongs_to :product
  # has_many :progesses #gotta find a better name

  attr_accessible :product_id, :order_id, :quantity, :completition, :unit_price
end