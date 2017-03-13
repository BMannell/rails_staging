require 'faker'

# Generate Users

User.destroy_all
Article.destroy_all

for i in 1..5
  User.create(name: Faker::LordOfTheRings.character, admin: (i == 1))
end

# Generate Articles

for i in 1..15
  Article.create(title: Faker::ChuckNorris.fact, content: Faker::Lorem.paragraph(3), user_id: Faker::Number.between(1, 5), image: Faker::Fillmurray.image(false, "500", "500"))
end

# Generate Some Stages
