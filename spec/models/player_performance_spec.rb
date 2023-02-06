require 'rails_helper'

RSpec.describe PlayerPerformance, type: :model do
  describe 'associations' do
    it { should belong_to(:player) }
    it { should belong_to(:performance_goal) }
    it { should belong_to(:match) }
  end
end
