require "rails_helper"

# Testing player mode
RSpec.describe Team, type: :model do
  describe 'A New team' do
    let(:team) { build(:team) }
    let(:players) { create_list(:player, 2) }

    it 'is invalid without two players' do
      team.players << players.first
      team.save
      expect(team.valid?).to be false
    end

    it 'is valid with two players' do
      team.players = []
      team.players << players.first
      team.players << players.second

      team.save
      expect(team.valid?).to be true
    end
  end
end
