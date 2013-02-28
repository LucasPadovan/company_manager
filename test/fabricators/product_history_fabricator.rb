Fabricator(:product_history) do
  purchase_price { 100.0 * rand }
  sale_price { 100.0 * rand }
  product_id { 100 * rand }
  user_id { 100 * rand }
  firm_id { 100 * rand }
  date { rand(1.year).ago }
end
