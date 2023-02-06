FactoryBot.define do
  factory :team do
    title { 'team title' }

    trait :invalid do
      first_name { nil }
  end
end
