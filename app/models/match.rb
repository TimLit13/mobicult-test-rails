class Match < ApplicationRecord
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'

  def teams
    Team.find(self.home_team_id, self.away_team_id)
  end
end
