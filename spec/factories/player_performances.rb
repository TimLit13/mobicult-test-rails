FactoryBot.define do
  factory :player_performance do
    player { nil }
    performance_goal { nil }
    match { nil }
    reached_performance { false }
  end
end
