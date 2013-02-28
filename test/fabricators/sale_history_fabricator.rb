Fabricator(:sale_history) do
  date { rand(1.year).ago }
  price { 100.0 * rand }
  product_id { 100 * rand }
  firm_id { 100 * rand }
end
