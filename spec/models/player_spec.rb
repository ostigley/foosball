require 'rails_helper'

# Testing player mode
RSpec.describe Player, type: :model do
  describe 'Players' do
    let(:player) { create(:player) }
    let(:team) { build(:team) }

    it 'have name' do
      expect(player.name.present?).to be true
    end
  end

  let(:players) { create_list(:player, 3) }
  let(:team1) { create(:team, players: [players.first, players.second]) }
  let(:team2) { create(:team, players: [players.first, players.third]) }
  describe 'A player can' do
    it 'have many teams' do
      expect(team1.valid?).to be true
      expect(team2.valid?).to be true
    end
  end

  describe '#team_mates' do
    it 'returns a list of players that are in that person\'s team' do
      players.first.teams = [team1, team2]
      expect(players.first.team_mates).to eq [players.second, players.third]
    end
  end
end
