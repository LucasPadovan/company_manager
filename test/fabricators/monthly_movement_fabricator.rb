Fabricator(:monthly_movement) do
  month { Faker::Lorem.sentence }
  year { 100 * rand }
  user_id { 100 * rand }
  status { Faker::Lorem.sentence }
  total { 100.0 * rand }
  iva_total_float { Faker::Lorem.sentence }
  otros_conc_total { 100.0 * rand }
  subtotal_consumo { 100.0 * rand }
  subtotal { 100.0 * rand }
end
