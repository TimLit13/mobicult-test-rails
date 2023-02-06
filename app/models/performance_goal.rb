class PerformanceGoal < ApplicationRecord
  has_many :player_performances, dependent: :destroy

  validates :title, :value, presence: true
end
