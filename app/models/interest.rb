class Interest < ActiveRecord::Base
  belongs_to :product
  belongs_to :firm

  has_many :product_histories
  has_many :sale_histories
end