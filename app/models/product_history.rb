class ProductHistory < ActiveRecord::Base
  has_paper_trail

  belongs_to :product
  belongs_to :user
  belongs_to :firm

  attr_accessible :purchase_price, :sale_price, :product_id, :user_id, :firm_id, :date

  end
