class PerformanceGoal < ApplicationRecord
  validates :title, :value, presence: true
end
