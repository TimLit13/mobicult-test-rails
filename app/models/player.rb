class Player < ApplicationRecord
  has_many :player_performances, dependent: :destroy
  belongs_to :team

  validates :first_name, :last_name, presence: true

  def reached_performance?(performance_goal_title, matches_count)
    performance_goal_id = PerformanceGoal.find_by(title: performance_goal_title.to_sym).id
    PlayerPerformance.where(performance_goal_id: performance_goal_id, player_id: self.id)
                     .last(matches_count)
                     .inject(false) { |result, player_performance| result || player_performance.reached_performance }
  end
end
