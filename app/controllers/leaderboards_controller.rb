class LeaderboardsController < ApplicationController
  include LeaderboardStats
  def index
    @teams = LeaderboardStats::Leaderboard.new(Team.all).team_leaderboard
  end

end