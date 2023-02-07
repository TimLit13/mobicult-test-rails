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


  describe '.top_players_by_performance' do
    let(:teams) { create_list(:team, 2) }
    let(:players) { create_list(:player, 5, team_id: teams.first.id) }
    let(:ended_match) { create(:match, home_team_id: teams.first.id, away_team_id: teams.last.id) }
    let(:performance_goal) { create(:performance_goal) }
    let!(:first_player_reached_performance_goals) do
      create_list(:player_performance,
                  4,
                  match_id: ended_match.id,
                  performance_goal_id: performance_goal.id,
                  player_id: players.first.id,
                  reached_performance: true)
    end
    let!(:second_player_reached_performance_goals) do
      create_list(:player_performance,
                  4,
                  match_id: ended_match.id,
                  performance_goal_id: performance_goal.id,
                  player_id: players[1].id,
                  reached_performance: true)
    end
    let!(:third_player_reached_performance_goals) do
      create_list(:player_performance,
                  3,
                  match_id: ended_match.id,
                  performance_goal_id: performance_goal.id,
                  player_id: players[2].id,
                  reached_performance: true)
    end
    let!(:fourth_player_reached_performance_goals) do
      create_list(:player_performance,
                  2,
                  match_id: ended_match.id,
                  performance_goal_id: performance_goal.id,
                  player_id: players[3].id,
                  reached_performance: true)
    end

    let!(:fifth_player_reached_performance_goals) do
      create_list(:player_performance,
                  5,
                  match_id: ended_match.id,
                  performance_goal_id: performance_goal.id,
                  player_id: players.last.id)
    end

    it 'returns 3 top players' do
      expect(described_class.top_players_by_performance(performance_goal.title, 3).count).to eq(3)
    end

    it 'includes only 3 players with top performance' do
      expect(described_class.top_players_by_performance(performance_goal.title, 3))
        .to include(players.first, players[1], players[2])
    end

    it 'does not include only players without performance or not top players' do
      expect(described_class.top_players_by_performance(performance_goal.title, 3))
        .not_to include(players[3], players.last)
    end

    it 'returns empty AR relation if no records found' do
      players.each(&:destroy)

      expect(described_class.top_players_by_performance(performance_goal.title, 3).count).to eq(0)
    end
  end

  describe '.top_team_players_by_performance' do
    let(:teams) { create_list(:team, 2) }
    let(:first_team_players) { create_list(:player, 5, team_id: teams.first.id) }
    let(:second_team_player) { create(:player, team_id: teams.last.id) }
    let(:ended_match) { create(:match, home_team_id: teams.first.id, away_team_id: teams.last.id) }
    let(:performance_goal) { create(:performance_goal) }
    let!(:first_player_reached_performance_goals) do
      create_list(:player_performance,
                  4,
                  match_id: ended_match.id,
                  performance_goal_id: performance_goal.id,
                  player_id: first_team_players.first.id,
                  reached_performance: true)
    end
    let!(:second_player_reached_performance_goals) do
      create_list(:player_performance,
                  4,
                  match_id: ended_match.id,
                  performance_goal_id: performance_goal.id,
                  player_id: first_team_players[1].id,
                  reached_performance: true)
    end
    let!(:third_player_reached_performance_goals) do
      create_list(:player_performance,
                  3,
                  match_id: ended_match.id,
                  performance_goal_id: performance_goal.id,
                  player_id: first_team_players[2].id,
                  reached_performance: true)
    end
    let!(:fourth_player_reached_performance_goals) do
      create_list(:player_performance,
                  2,
                  match_id: ended_match.id,
                  performance_goal_id: performance_goal.id,
                  player_id: first_team_players[3].id,
                  reached_performance: true)
    end

    let!(:fifth_player_reached_performance_goals) do
      create_list(:player_performance,
                  5,
                  match_id: ended_match.id,
                  performance_goal_id: performance_goal.id,
                  player_id: first_team_players.last.id)
    end

    let!(:sixth_player_reached_performance_goals) do
      create_list(:player_performance,
                  6,
                  match_id: ended_match.id,
                  performance_goal_id: performance_goal.id,
                  player_id: second_team_player.id,
                  reached_performance: true)
    end

    it 'returns 3 top players' do
      expect(described_class.top_team_players_by_performance(performance_goal.title, 3, teams.first).count).to eq(3)
    end

    it 'includes only 3 players with top performance' do
      expect(described_class.top_team_players_by_performance(performance_goal.title, 3, teams.first))
        .to include(first_team_players.first, first_team_players[1], first_team_players[2])
    end

    it 'does not include only players without performance or not top players' do
      expect(described_class.top_team_players_by_performance(performance_goal.title, 3, teams.first))
        .not_to include(first_team_players[3], first_team_players.last)
    end

    it 'does not include players with better performances from other team' do
      expect(described_class.top_team_players_by_performance(performance_goal.title, 3, teams.first))
        .not_to include(second_team_player)
    end

    it 'returns empty AR relation if no records found' do
      first_team_players.each(&:destroy)
      second_team_player.destroy

      expect(described_class.top_team_players_by_performance(performance_goal.title, 3, teams.first).count).to eq(0)
    end
  end
end
