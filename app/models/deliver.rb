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
end