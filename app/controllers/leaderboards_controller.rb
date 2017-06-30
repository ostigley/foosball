class LeaderboardsController < ApplicationController
  include LeaderboardStats

  def index
    @game_count = Game.all.count
    @teams = LeaderboardStats::Leaderboard.new(Team.all).team_leaderboard
    @players = LeaderboardStats::Leaderboard.new(nil, Player.all).player_leaderboard
  end

end