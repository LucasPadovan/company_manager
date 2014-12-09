class Item < ActiveRecord::Base
  has_paper_trail

  belongs_to :order
  belongs_to :product
  has_many :delivers

  attr_accessible :product_id, :order_id, :quantity, :completition, :unit_price

  validates_presence_of :quantity, :product_id, :order_id
end