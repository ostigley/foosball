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
      Results::Result.new(game).generate_elo_rankings
    end
  end
end


