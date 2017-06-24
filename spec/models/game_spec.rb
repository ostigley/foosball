require 'rails_helper'

# Testing game model
RSpec.describe Game, type: :model do
  let(:teams) { create_list(:team, 2, :full_team) }
  let(:game) { build(:game) }
  let(:full_game) { create(:game) }

  describe 'A New game' do
    it 'is valid with two teams' do
      game.teams = teams
      game.save!
      expect(game.valid?).to be true
    end

    it 'is invalid without exactly teams' do
      game.teams = [teams.first]
      game.save
      expect(game.valid?).to be false
    end
  end

  describe '#players' do
    it 'returns list of players in the game' do
      expect(full_game.players).to eq [Player.first, Player.second, Player.third, Player.fourth]
    end
  end

  describe 'Assigning a winner' do
    it 'saves a new winner' do
      full_game.create_winner(team: full_game.teams.first)

      expect(full_game.valid?).to be true
      expect(Winner.all.count).to eq 1
    end
  end

  describe 'Assigning a Loser' do
    it 'saves a new loser' do
      full_game.create_loser(team: full_game.teams.second)
      expect(full_game.valid?).to be true
      expect(Loser.all.count).to eq 1
    end
  end

end
