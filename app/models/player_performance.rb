class PlayerPerformance < ApplicationRecord
  belongs_to :player
  belongs_to :performance_goal
  belongs_to :match

  def performance_goal_reached
    self.update(reached_performance: true)
  end
end
