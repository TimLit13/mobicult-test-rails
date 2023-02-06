require 'rails_helper'

RSpec.describe PerformanceGoal, type: :model do
  describe 'associations' do
    it { should have_many(:player_performances).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :value }
  end
end
