FactoryBot.define do
  factory :team do
    title { 'team title' }

    trait :invalid do
      title { nil }
  end
end
