
module Results
  class Result
    def initialize(game)

      @game = game
      ELO_EXCHANGE_TABLE
    end

    def set_winner(winner_id, loser_id)
      @game.create_winner(team_id: winner_id)
      @game.create_loser(team_id: loser_id)
      @game.save!
    end

    def confirm_winner(winner, confirmation)
      winner.confirmed = confirmation
      winner.save!

      generate_elo_rankings
    end

    def generate_elo_rankings
      better_team, worse_team = @game.teams.order(elo_ranking: :desc)

      elo_result = if @game.winner.team === better_team
                    better_team.elo_ranking - worse_team.elo_ranking
                  else
                    worse_team.elo_ranking - better_team.elo_ranking
                  end

      elo_exchange = ELO_EXCHANGE_TABLE.select { |diff| diff === elo_result }.values.first

      @game.winner_players.each do |player|
        player.update_attribute(:elo_ranking, player.elo_ranking + elo_exchange)
      end

      @game.loser_players.each do |player|
        player.update_attribute(:elo_ranking, player.elo_ranking - elo_exchange)
      end

      @game.teams.each do |team|
        average_elo = (team.players.first.elo_ranking + team.players.second.elo_ranking)/2
        team.update_attribute(:elo_ranking, average_elo.to_i)
      end
    end
  end
end
