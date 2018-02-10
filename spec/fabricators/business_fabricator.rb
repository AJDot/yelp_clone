Fabricator(:business) do
  name { Faker::App.name }
  description { Faker::Lorem.paragraphs(2).join(" ") }
end
