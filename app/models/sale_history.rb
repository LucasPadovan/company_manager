class SaleHistory < ActiveRecord::Base
  has_paper_trail

  belongs_to :firm
  belongs_to :product

  attr_accessible :date, :price, :product_id, :firm_id

  end
