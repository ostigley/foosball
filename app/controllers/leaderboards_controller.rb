# frozen_string_literal: true

class LeaderboardsController < ApplicationController
  def index
    @game_count = Game.all.count
    @teams = Team.order(elo_ranking: :desc)
    @players = Player.order(elo_ranking: :desc)
  end
end
