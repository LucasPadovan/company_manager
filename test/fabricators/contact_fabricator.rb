Fabricator(:contact) do
  name { Faker::Name.name }
  area { Faker::Lorem.sentence }
  details { Faker::Lorem.paragraph }
  firm_id { references }
end
