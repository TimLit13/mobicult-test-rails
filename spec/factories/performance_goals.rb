FactoryBot.define do
  factory :performance_goal do
    title { 'Scores' }
    value { 1 }

    trait :invalid do
      title { nil }
    end
    
  end
end
