# Games controller
class GamesController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @game = Game.new
    @player_teams = current_player.team
    @teams = Team.exclude_player_teams @player_teams
  end

  def create
    @game = Game.new
  end

  def index
    @games = Game.all
  end

  private

  def game_params
    params.require(:game).permit(:team_ids)
  end
end
