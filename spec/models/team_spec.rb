require 'rails_helper'

# Testing player mode
RSpec.describe Team, type: :model do
  let(:players) { create_list(:player, 2) }
  let(:team) { create(:team, players: [players.first, players.second]) }
  describe 'A New team' do

    it 'is invalid without two players' do
      team.players = [players.first]
      team.save
      expect(team.valid?).to be false
    end

    it 'is valid with two players' do
      expect(team.valid?).to be true
    end
  end

  describe '#team_name' do
    it 'returns a team name' do
      expect(team.team_name).to eq "#{players.first.name} & #{players.second.name}"
    end
  end
end
