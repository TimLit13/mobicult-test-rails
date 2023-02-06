class Team < ApplicationRecord
  has_many :players, dependent: :destroy

  validates :title, presence: true
end
