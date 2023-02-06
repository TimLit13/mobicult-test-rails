class Team < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :home_matches, class_name: 'Match', foreign_key: 'home_team_id', dependent: :destroy, inverse_of: :home_team
  has_many :away_matches, class_name: 'Match', foreign_key: 'away_team_id', dependent: :destroy, inverse_of: :away_team

  validates :title, presence: true
end
