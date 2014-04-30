class SaleHistory < ActiveRecord::Base
  has_paper_trail

  belongs_to :interest

  attr_accessible :date, :price, :interest_id

  validates :price, presence: true

end
