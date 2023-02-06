class Player < ApplicationRecord
  has_many :player_performances, dependent: :destroy
  belongs_to :team

  validates :first_name, :last_name, presence: true
end
