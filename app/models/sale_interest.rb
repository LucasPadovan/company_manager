class SaleInterest < Interest

  def price
     prices.last.sale_price if prices.any?
  end

end
