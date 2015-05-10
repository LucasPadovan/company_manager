class Deliver < ActiveRecord::Base
  belongs_to :item
  # belongs_to :receipt

  attr_accessible :receipt_id, :item_id, :quantity, :delivered_at

  before_save :add_to_item_completition
  before_destroy :discount_item_completition

  private
    def add_to_item_completition
      self.item.completition += quantity
      self.item.save
    end

    def discount_item_completition
      item.completition -= quantity
      item.save
    end
  #todo: relacion muchos a muchos, un solo deliver puede tener mas de un item, entonces hago entregas mas generales, con una lista de items.
  #      al crear un nuevo deliver, que descuente de los completition la cantidad indicada en cada uno de los deliverItem (relacion intermedia con la cantidad solamente)

  #      belongs_to :order

  #      asi tambien tengo una sola fecha y cada uno de estos deliver puede tener su propio remito => belongs_to :receipt
end