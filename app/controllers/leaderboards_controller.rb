class LeaderboardsController < ApplicationController
  include LeaderboardStats

  def index
    @teams = LeaderboardStats::Leaderboard.new(Team.all).team_leaderboard
    @players = LeaderboardStats::Leaderboard.new(nil, Player.all).player_leaderboard
  end

end