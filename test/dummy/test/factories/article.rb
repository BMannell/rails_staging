FactoryGirl.define do
  factory :article do

    title {Faker::ChuckNorris.fact}
    content {Faker::Lorem.paragraph(3)}
    user_id {Faker::Number.between(1, 5)}
    image {Faker::Fillmurray.image(false, "500", "500")}

  end
end
