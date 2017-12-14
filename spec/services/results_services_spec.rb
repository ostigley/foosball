require 'rails_helper'

RSpec.describe 'Results Services', type: :service do
  describe '# generate elo rankings' do
    let(:team1) { create(:team, :full_team) }
    let(:team2) { create(:team, :full_team) }
    let(:game) { create(:game) }

    before do
      game.teams = [team1, team2]
      game.save!
    end

    describe 'for players with the same elo ranking' do
      before do
        game.create_winner(team: team1)
        game.create_loser(team: team2)
        Results::Result.new(game).generate_elo_rankings
        game.reload
      end

      it 'increases winner players elo by 16 points' do
        game.winner_players.each do |player|
          expect(player.elo_ranking).to eq 1416
        end
      end

      it 'decreases loser players elo by 16 points' do
        game.loser_players.each do |player|
          expect(player.elo_ranking).to eq 1384
        end
      end
    end

    describe 'for players with extreme opposite elo rankings' do
      before do
        team1.players.each do |player|
          player.elo_ranking = 5000
          player.save!
        end

        team1.update_attributes(elo_ranking: 5000)

        team2.players.each do |player|
          player.elo_ranking = 100
          player.save!
        end
        team2.update_attributes(elo_ranking: 100)

      end

      context 'if the really good team wins' do
        before do
          game.create_winner(team: team1)
          game.create_loser(team: team2)
          Results::Result.new(game).generate_elo_rankings
          game.reload
        end

        it 'does not increase winning players elo_ranking at all' do
          game.winner_players.each do |player|
            expect(player.elo_ranking).to eq 5000
          end
        end

        it 'does not reduce losing players elo_ranking at all' do
          game.loser_players.each do |player|
            expect(player.elo_ranking).to eq 100
          end
        end
      end

      context 'if the really bad team wins' do
        before do
          game.create_winner(team: team2)
          game.create_loser(team: team1)
          Results::Result.new(game).generate_elo_rankings
          game.reload
        end

        it 'increases thes winning players elo_ranking by 32' do
          game.winner_players.each do |player|
            expect(player.elo_ranking).to eq 100+32
          end
        end

        it 'reduces the losing players elo_ranking by 32' do
          game.loser_players.each do |player|
            expect(player.elo_ranking).to eq 5000-32
          end
        end
      end
    end

  end


end