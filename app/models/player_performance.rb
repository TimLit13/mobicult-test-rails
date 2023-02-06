class PlayerPerformance < ApplicationRecord
  belongs_to :player
  belongs_to :performance_goal
  belongs_to :match
end
