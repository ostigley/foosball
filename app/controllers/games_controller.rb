# Games controller
class GamesController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update]
  before_action :find_game, only: [:show, :edit, :update]
  before_action :player_in_game, only: [:edit, :update]

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

  def index
    @games = Game.all
  end

  def edit
  end

  private

  def game_params
    params.require(:game).permit(:id, :team_ids => [])
  end

  def find_game
    @game = Game.find_by_id(params[:id])
  end

  def player_in_game
    redirect_to games_index_path unless @game.players.include? current_player
  end

end
