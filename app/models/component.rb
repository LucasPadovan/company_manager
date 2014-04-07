class Component < ActiveRecord::Base
  belongs_to :product
  belongs_to :custom_product

  attr_accessible :product_id, :custom_product_id

end