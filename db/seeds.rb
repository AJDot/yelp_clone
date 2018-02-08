# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

alice = Fabricate(:user, first_name: 'Alice', email: 'alice@example.com', password: 'password')
bob = Fabricate(:user, first_name: 'Bob', email: 'bob@example.com', password: 'password')

alpha = Fabricate(:business, name: 'alpha')
beta = Fabricate(:business, name: 'beta')
gamma = Fabricate(:business, name: 'gamma')
