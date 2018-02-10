# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

alex = Fabricate(:user, first_name: 'Alex', email: 'alex@example.com', password: 'password')

Fabricate.times(4, :user)

Fabricate.times(20, :business)

Fabricate.times(100, :review) do
  user { User.all.sample }
  business { Business.all.sample }
  created_at { Faker::Date.between(5.years.ago, Date.today) }
end
