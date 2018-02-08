Fabricator(:user) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { Faker::Internet.email }
  password { Faker::Lorem.characters(10) }
  password_confirmation { |attrs| attrs[:password] }
end
