FactoryBot.define do
  factory :player do
    first_name { 'MyString' }
    last_name { 'MyText' }

    trait :invalid do
      first_name { nil }
    end
  end
end
