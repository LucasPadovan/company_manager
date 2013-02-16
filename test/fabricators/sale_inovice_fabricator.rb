Fabricator(:sale_invoice) do
  date { rand(1.year).ago }
  invoice_type { Faker::Lorem.sentence }
  number { Faker::Lorem.sentence }
  iva { 100.0 * rand }
  subtotal { 100.0 * rand }
  total { 100.0 * rand }
  retencion { 100.0 * rand }
  other_concepts { 100.0 * rand }
  firm_id { 100 * rand }
  monthly_movement_id { 100 * rand }
end
