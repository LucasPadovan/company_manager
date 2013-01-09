Fabricator(:firm) do
  nombre { Faker::Lorem.sentence }
  cuit { Faker::Lorem.sentence }
  afip_cond { Faker::Lorem.sentence }
end
