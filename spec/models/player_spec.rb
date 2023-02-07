require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'associations' do
    it { should have_many(:player_performances).dependent(:destroy) }
    it { should belong_to(:team) }
  end

  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe '#reached_performance?' do
    let(:teams) { create_list(:team, 2) }
    let(:player) { create(:player, team_id: teams.first.id) }
    let(:ended_match) { create(:match, home_team_id: teams.first.id, away_team_id: teams.last.id) }
    let(:performance_goal) { create(:performance_goal) }
    let!(:not_reached_performance_goals) do
      create_list(:player_performance,
                  4,
                  match_id: ended_match.id,
                  performance_goal_id: performance_goal.id,
                  player_id: player.id)
    end
    let!(:reached_performance_goal) do
      create(:player_performance,
             match_id: ended_match.id,
             performance_goal_id: performance_goal.id,
             player_id: player.id,
             reached_performance: true)
    end

    it 'returns true if performance goal reached at least 1 time in 5 matches' do
      expect(player.reached_performance?(performance_goal.title, 5)).to be_truthy
    end

    it 'returns false if performance goal not reached at least 1 time in 5 matches' do
      reached_performance_goal.update(reached_performance: false)
      expect(player.reached_performance?(performance_goal.title, 5)).to be_falsey
    end
  end
end
