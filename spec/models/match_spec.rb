require 'rails_helper'

RSpec.describe Match, type: :model do
  describe 'associations' do
    it { should belong_to(:home_team) }
    it { should belong_to(:away_team) }
  end
end
