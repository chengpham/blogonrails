FactoryBot.define do
  factory :post do
    sequence(:title){ |n| Faker::Job.title + "#{n}"}
    body{ Faker::Lorem.sentence(word_count: 100) }
    association(:user, factory: :user)
  end
end
