require 'rails_helper'

# Testing game model
RSpec.describe Game, type: :model do
  let(:players) { create_list(:player, 5) }
  let(:team1) { build(:team) }
  let(:team2) { build(:team) }
  let(:game) { build(:game) }

  before do
    team1.players = [players.first, players.second]
    team2.players = [players.third, players.fourth]
    team1.save!
    team2.save!
  end

  describe 'A New game' do
    it 'is valid with two teams' do
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

  describe '#players' do
    it 'returns list of players in the game' do
      game.teams = [team1, team2]
      game.save
      expect(game.players).to eq [players.first, players.second, players.third, players.fourth]
    end
  end

  describe 'Assigning a winner' do
    it 'saves a new winner' do
      game.teams = [team1, team2]
      team1.save
      game.create_winner({team: team1})
      game.save

      expect(game.valid?).to be true
      expect(Winner.all.count).to eq 1
    end
  end

  describe 'Assigning a Loser' do
    it 'saves a new loser' do
      game.teams = [team1, team2]
      team1.save
      game.create_loser({team: team2})
      game.save

      expect(game.valid?).to be true
      expect(Loser.all.count).to eq 1
    end
  end

end
