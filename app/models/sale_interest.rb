class SaleInterest < Interest

  def price
     prices.last.sale_price if prices.any?
  end

  def self.column_names_for_export(first_column)
    [first_column, 'Fecha', 'Precio']
  end

  def to_csv(first_column)
    row = case first_column
            when 'Empresa' then [firm.to_s]
            else [product.to_s]
          end
    row << [date.strftime('%d/%m/%y %H:%Mhs'), price]
    row.flatten
  end

end
