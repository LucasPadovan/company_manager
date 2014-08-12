class PurchaseInterest < Interest

  def price
    prices.last.purchase_price if prices.any?
  end

  def proposed_sale_price
    prices.last.sale_price if prices.any?
  end

  def self.column_names_for_export(first_column)
    [first_column, 'Fecha', 'Precio de compra', 'Precio de venta']
  end

  def to_csv(first_column)
    row = case first_column
            when 'Empresa' then [firm.to_s]
            else [product.to_s]
          end
    row << [date.strftime('%d/%m/%y %H:%Mhs'), price, proposed_sale_price]
    row.flatten
  end

end
