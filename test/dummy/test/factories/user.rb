FactoryGirl.define do
  factory :user do
    name {Faker::Name.name}
    admin false

    trait :admin do
      admin true
    end
  end
end
