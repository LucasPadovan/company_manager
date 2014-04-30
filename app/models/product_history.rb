class ProductHistory < ActiveRecord::Base
  has_paper_trail

  belongs_to :user
  belongs_to :interest

  attr_accessible :date, :purchase_price, :sale_price, :interest_id, :user_id

  validates :purchase_price, presence: true

end
