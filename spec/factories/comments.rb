FactoryBot.define do
  factory :comment do
    body{ Faker::Hipster.paragraph }
    association(:user, factory: :user)
    association(:post, factory: :post)
  end
end
