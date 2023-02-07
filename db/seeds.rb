require 'faker'

# instances amount
PLAYERS_SEED = 22
TEAMS_SEED = 2
MATCHES_SEED = 5
PLAYER_PERFORMANCES_SEED = 100

# clear db before seed
PlayerPerformance.delete_all if PlayerPerformance.any?
PerformanceGoal.delete_all if PerformanceGoal.any?
Match.delete_all if Match.any?
Player.delete_all if Player.any?
Team.delete_all if Team.any?

# seed teams
teams = []

1.upto(TEAMS_SEED) { teams.push(Team.create(title: Faker::Sports::Football.team)) }

# seed players
players = []

1.upto(PLAYERS_SEED) do |ind|
  first_name, last_name = Faker::Sports::Football.player.split
  team = ind.odd? ? teams.first : teams.last
  players.push(Player.create(first_name: first_name, last_name: last_name, team_id: team.id))
end

# seed matches
matches = []

1.upto(MATCHES_SEED) do
  matches.push(Match.create(home_team_id: teams.first.id, away_team_id: teams.last.id))
end

# seed performance goals
performance_goals = [PerformanceGoal.create(title: 'Scores', value: 3),
                     PerformanceGoal.create(title: 'Assists', value: 2)]

# seed player performances
players.each do |player|
  matches.each do |match|
    PlayerPerformance.create(player_id: player.id,
                             performance_goal_id: performance_goals.sample.id,
                             match_id: match.id,
                             reached_performance: [true, false].sample)
  end
end
