require "rails_helper"

# Testing player mode
RSpec.describe Player, type: :model do
  describe 'Players' do
    let(:player) { create(:player) }
    let(:team) { build(:team) }

    it 'have name' do
      expect(player.name.present?).to be true
    end
  end

  describe 'A player can' do
    let(:players) { create_list(:player, 2) }
    let(:team1) { build(:team) }
    let(:team2) { build(:team) }

    it 'have many teams' do
      team1.players = players
      team2.players = players

      team1.save!
      team2.save!

      expect(team1.valid?).to be true
      expect(team2.valid?).to be true
    end

  end

end
