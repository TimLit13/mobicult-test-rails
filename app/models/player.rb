class Player < ApplicationRecord
  has_many :player_performances, dependent: :destroy
  belongs_to :team

  validates :first_name, :last_name, presence: true

  class << self
    def top_players_by_performance(performance_goal_title, players_count)
      players_ids = PlayerPerformance.where(performance_goal_id: find_performance_goal_id(performance_goal_title),
                                            reached_performance: true)
                                     .group(:player_id)
                                     .count
                                     .sort_by { |_player, reached_player_performances| reached_player_performances }
                                     .to_h
                                     .keys
                                     .last(players_count)
      Player.where(id: [players_ids])
    end

    def top_team_players_by_performance(performance_goal_title, players_count, team)
      players_ids = PlayerPerformance.where(performance_goal_id: find_performance_goal_id(performance_goal_title),
                                            reached_performance: true)
                                     .joins(:player)
                                     .where(player: { team_id: team.id })
                                     .group(:player_id)
                                     .count
                                     .sort_by { |_player, reached_player_performances| reached_player_performances }
                                     .to_h
                                     .keys
                                     .last(players_count)
      Player.where(id: [players_ids])
    end

    def find_performance_goal_id(performance_goal_title)
      PerformanceGoal.find_by(title: performance_goal_title.to_sym).id
    end
  end

  def reached_performance?(performance_goal_title, matches_count)
    PlayerPerformance.where(performance_goal_id: find_performance_goal_id(performance_goal_title), player_id: self.id)
                     .last(matches_count)
                     .inject(false) { |result, player_performance| result || player_performance.reached_performance }
  end

  private

  def find_performance_goal_id(performance_goal_title)
    PerformanceGoal.find_by(title: performance_goal_title.to_sym).id
  end
end
