require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'associations' do
    it { should have_many(:players).dependent(:destroy) }
    it { should have_many(:home_matches).dependent(:destroy) }
    it { should have_many(:away_matches).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
  end
end
