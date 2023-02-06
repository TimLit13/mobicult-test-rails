require 'rails_helper'

RSpec.describe PlayerPerformance, type: :model do
  describe 'associations' do
    it { should belong_to(:player) }
    it { should belong_to(:performance_goal) }
    it { should belong_to(:match) }
  end

  describe '#performance_goal_reached' do
    let(:teams) { create_list(:team, 2) }
    let(:first_player) { create(:player, team_id: teams.first.id) }
    let(:ended_match) { create(:match, home_team_id: teams.first.id, away_team_id: teams.last.id) }
    let(:performance_goal) { create(:performance_goal) }
    let(:player_performance) do
      create(:player_performance,
             match_id: ended_match.id,
             performance_goal_id: performance_goal.id,
             player_id: first_player.id)
    end

    it 'set true for player_performance value' do
      player_performance.performance_goal_reached
      expect(player_performance.performance_goal_reached).to be_truthy
    end
  end
end
