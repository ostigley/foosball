require 'rails_helper'

# Testing player mode
RSpec.describe Player, type: :model do
  let(:players) { create_list(:player, 3) }
  let(:teams) { create_list(:team, 2, :full_team) }
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
end
