require 'rails_helper'

RSpec.describe PerformanceGoal, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :value }
  end
end
