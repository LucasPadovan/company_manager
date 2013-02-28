Fabricator(:product) do
  name { Faker::Name.name }
  description { Faker::Lorem.paragraph }
  rubro { Faker::Lorem.sentence }
  user_id { 100 * rand }
end
