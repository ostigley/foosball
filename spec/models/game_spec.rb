require 'rails_helper'

# Testing game model
RSpec.describe Game, type: :model do
  let(:players) { create_list(:player, 5) }
  let(:team1) { build(:team) }
  let(:team2) { build(:team) }
  let(:game) { build(:game) }

  describe 'A New game' do
    before do
      team1.players = [players.first, players.second]
      team2.players = [players.third, players.fourth]
      team1.save!
      team2.save!
    end

    it 'is valid with two teams' do
      # binding.pry
      game.teams = [team1, team2]
      game.save!
      expect(game.valid?).to be true
    end

    it 'is invalid without exactly teams' do
      game.teams = [team1]
      game.save
      expect(game.valid?).to be false
    end
  end
end
