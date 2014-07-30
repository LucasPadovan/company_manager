class PurchaseInterest < Interest

  def price
    prices.last.purchase_price if prices.any?
  end

  def proposed_sale_price
    prices.last.sale_price if prices.any?
  end

end
