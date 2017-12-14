namespace :generate_elo do

  task :generate_all_teams => :environment do
    Team.all.map do |team|
      average_elo = (team.players.first.elo_ranking + team.players.second.elo_ranking)/2
      team.update_attribute(:elo_ranking, average_elo.to_i)
    end
  end

  task :generate_all_player => :environment do
    games = Game.order(created_at: :asc)
    games.each do |game|
      team_1 = game.teams.first
      team_2 = game.teams.second

      team_1_elo_ranking = team_1.elo_ranking #average of player elo
      team_2_elo_ranking = team_2.elo_ranking #average of player elo

      elo_result = if game.winner.team === team_1
                    team_1_elo_ranking - team_2_elo_ranking
                  else
                    team_2_elo_ranking - team_2_elo_ranking
                  end

      elo_exchange = ELO_EXCHANGE_TABLE.select { |diff| diff === elo_result }.values.first

      game.winner.team.players.each do |player|
        player.update_attribute(:elo_ranking, player.elo_ranking + elo_exchange)
      end

      game.loser.team.players.each do |player|
        player.update_attribute(:elo_ranking, player.elo_ranking - elo_exchange)
      end

    end
  end
end


