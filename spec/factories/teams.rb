FactoryBot.define do
  factory :team do
    title { 'Team' }
  end

  trait :invalid do
      title { nil }
    end
end
