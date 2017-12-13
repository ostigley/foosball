namespace :generate_elo do

  task :generate_all_teams => :environment do
    games = Game.order(created_at: :asc)
    games.each do |game|
      team_1_elo_ranking = game.teams.first.elo_ranking
      team_2_elo_ranking = game.teams.second.elo_ranking

      team_1_expected_score = team_1_elo_ranking / (team_1_elo_ranking + team_2_elo_ranking)
      team_2_expected_score = team_2_elo_ranking / (team_1_elo_ranking + team_2_elo_ranking)

      team_1_actual_score = game.winner.team == game.teams.first ? 1 : 0
      team_2_actual_score = game.winner.team == game.teams.second ? 1 : 0

      game.teams.first.update_attribute(:elo_ranking, team_1_elo_ranking + K_VALUE*(team_1_actual_score - team_1_expected_score) )
      game.teams.second.update_attribute(:elo_ranking, team_2_elo_ranking + K_VALUE*(team_2_actual_score - team_2_expected_score) )
    end
  end

  task :generate_all_player => environment do

    players = Player.all

    games = Game.order(created_at: :asc)
    games.each do |game|
      team_1_elo_ranking = game.teams.first.elo_ranking
      team_2_elo_ranking = game.teams.second.elo_ranking

      team_1_expected_score = team_1_elo_ranking / (team_1_elo_ranking + team_2_elo_ranking)
      team_2_expected_score = team_2_elo_ranking / (team_1_elo_ranking + team_2_elo_ranking)

      team_1_actual_score = game.winner.team == game.teams.first ? 1 : 0
      team_2_actual_score = game.winner.team == game.teams.second ? 1 : 0

      game.teams.first.update_attribute(:elo_ranking, team_1_elo_ranking + K_VALUE*(team_1_actual_score - team_1_expected_score) )
      game.teams.second.update_attribute(:elo_ranking, team_2_elo_ranking + K_VALUE*(team_2_actual_score - team_2_expected_score) )
    end
  end
end
