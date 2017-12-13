class LeaderboardsController < ApplicationController
  include LeaderboardStats

  def index
    @game_count = Game.all.count
    @teams = LeaderboardStats::Leaderboard.new(Team.order(elo_ranking: :desc)).team_leaderboard
    @players = LeaderboardStats::Leaderboard.new(nil, Player.order(elo_ranking: :desc)).player_leaderboard
  end

end