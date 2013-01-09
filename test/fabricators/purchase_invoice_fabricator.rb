Fabricator(:purchase_invoice) do
  date { rand(1.year).ago }
  type { Faker::Lorem.sentence }
  iva { 100.0 * rand }
  subtotal { 100.0 * rand }
  total { 100.0 * rand }
  firm_id { 100 * rand }
end
