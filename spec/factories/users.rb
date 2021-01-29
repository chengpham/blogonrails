FactoryBot.define do
  factory :user do
    name{Faker::Name.name}
    sequence(:email){|n| "john-#{n}@smith.com"}
    password{"supersecret"}
  end
end
