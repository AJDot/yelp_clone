Fabricator(:review) do
  user { Fabricate(:user) }
  business { Fabricate(:business) }
  rating { [1, 2, 3, 4, 5].sample }
  body { Faker::Lorem.paragraphs(2).join(" ") }
end
