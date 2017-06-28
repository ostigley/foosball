require 'rails_helper'

# Testing player mode
RSpec.describe Player, type: :model do
  let(:players) { create_list(:player, 3) }
  let(:teams) { create_list(:team, 2, :full_team) }
  let(:game) { create(:game, teams: teams) }

  describe 'Player attributes' do

    it 'have name' do
      expect(players.first.name.present?).to be true
    end

    it 'have email' do
      expect(players.first.email.present?).to be true
    end
  end

  describe 'Player teams' do
    it 'can have many teams' do
      teams.first.players = players.first(2)
      teams.second.players = players.first(2)

      expect(teams.first.valid?).to be true
      expect(teams.first.valid?).to be true
    end
  end

  describe '#games' do

    it 'returns the games the player has won' 
  end

  describe '#winner' do
    it 'returns the Wins the player has won'
  end

  describe '#loser' do
    it 'returns the Loses the player has lost'
  end

  describe '#team_name' do
    it 'returns the name of the player' do
      expect(players.first.team_name).to eq players.first.name
    end
  end

end
