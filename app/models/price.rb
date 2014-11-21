class Price < ActiveRecord::Base
  # todo: implementar precio unitario, precios por cantidad, precios optimos, precios por lote cerrado
  has_paper_trail

  belongs_to :user
  belongs_to :interest

  attr_accessible :date, :purchase_price, :sale_price, :interest_id, :user_id

end
