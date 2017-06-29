require 'rails_helper'

# Testing player mode
RSpec.describe Team, type: :model do
  # let(:players) { create_list(:player, 2) }
  let(:team) { create(:team, :full_team) }
  describe 'A New team' do

    it 'is invalid without two players' do
      team.players = []
      team.save
      expect(team.valid?).to be false
    end

    it 'is valid with two players' do
      expect(team.valid?).to be true
    end
  end

  describe '#team_name' do
    it 'returns a team name' do
      expect(team.team_name).to eq "#{Player.first.name} & #{Player.second.name}"
    end
  end

  describe '#image' do
    it 'returns a string of image tags from each player' do
      expect(team.image).to eq "<img src=#{team.players.first.image}> <img src=#{team.players.second.image}>"
    end
  end
end
