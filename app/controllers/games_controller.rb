# Games controller
class GamesController < ApplicationController
  include Results

  before_action :require_login
  before_action :find_game, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_player_not_in_game, only: [:edit, :update, :destroy]
  before_action :already_has_winner, only: [:edit, :update]
  before_action :select_team, only: [:update]

  def new
    @game = Game.new
    @teams = Team.all
  end

  def create
    team_ids = game_params[:team_ids]
    @game = Game.new(team_ids: team_ids)

    if @game.save
      flash[:success] = Faker::ChuckNorris.fact
      redirect_to games_path id: @game.id
    else
      flash[:alert] = @game.errors.full_messages.to_sentence
      redirect_to games_new_path
    end
  end

  def index
    @games = current_player.games
  end

  def show
    game_has_no_winner = @game.winner.nil?
    win_unconfirmed = !@game.winner.try(:confirmed)

    game_need_update = player_in_game? && (game_has_no_winner || win_unconfirmed)

    redirect_to(edit_games_path(id: params[:id])) if game_need_update
  end

  def update
    if Results::Result.new(@game, @winning_team).set_winner
      redirect_to games_path id: @game.id
    else
      flash[:notice] = @game.errors
    end
  end

  def destroy
    @game.winner.delete unless @game.winner.nil?
    @game.loser.delete unless @game.loser.nil?
    @game.delete
    flash[:success] = "Game deleted"
    redirect_to games_index_path
  end

  private

  def game_params
    params.require(:game).permit(:id, :team_id, :winner, :team_ids => [])
  end

  def find_game
    @game ||= Game.find_by_id(params[:id])
  end

  def already_has_winner
    return unless @game.winner && @game.winner.confirmed
    flash[:notice] = 'That game already has a winner'
    redirect_to games_index_path
  end

  def redirect_if_player_not_in_game
    redirect_to games_index_path unless player_in_game?
  end

  def player_in_game?
    @game.players.include? current_player
  end

  def select_team
    @winning_team = @game.teams.find { |team| team.id == game_params[:winner].to_i }
  end


end
