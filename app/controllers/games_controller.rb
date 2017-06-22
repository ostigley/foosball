# Games controller
class GamesController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
    @teams = Team.all
  end

  def create
    game_params[:team_ids].delete("")
    team_ids = game_params[:team_ids]
    team_ids.shift
    @game = Game.new
    @game.teams = [ Team.find_by_id(team_ids.first), Team.find_by_id(team_ids.second) ]

    if @game.save
      redirect_to games_path id: @game.id
    else
      render 'new'
    end
  end

  def show
    @game = Game.find_by_id(params[:id])
  end

  private

  def game_params
    params.require(:game).permit(:team_ids => [])
  end

end
