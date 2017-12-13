exchange_table = {
  -10..-1 => 16,
  -32..-11 => 17,
  -54..-33 => 18,
  -77..-55 => 19,
  -100..-78 => 20,
  -124..-101 => 21,
  -149..-125 => 22,
  -176..-150 => 23,
  -205..-177 => 24,
  -237..-206 => 25,
  -273..-238 => 26,
  -314..-274 => 27,
  -364..-315 => 28,
  -428..-365 => 29,
  -523..-429 => 30,
  -719..-524 => 31,
  -1000000000..-720 => 32,

  0..10 => 16,
  11..32 => 15,
  33..54 => 14,
  55..77 => 13,
  78..100 => 12,
  101..124 => 11,
  125..149 => 10,
  150..176 => 9,
  177..205 => 8,
  206..237 => 7,
  238..273 => 6,
  274..314 => 5,
  315..364 => 4,
  365..428 => 3,
  429..523 => 2,
  524..719 => 1,
  720..1000000000 => 0
}


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

      elo_exchange = exchange_table.select { |diff| diff === elo_result }.values.first

      game.winner.team.players.each do |player|
        player.update_attribute(:elo_ranking, player.elo_ranking + elo_exchange)
      end

      game.loser.team.players.each do |player|
        player.update_attribute(:elo_ranking, player.elo_ranking - elo_exchange)
      end

    end
  end
end


