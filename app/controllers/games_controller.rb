# Games controller
class GamesController < ApplicationController
  include Results

  before_action :require_login
  before_action :find_game, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_player_not_in_game, only: [:edit, :update, :destroy]
  before_action :game_completed, only: [:edit, :update]
  before_action :select_team, only: [:update]

  def new
    flash[:success] = Faker::ChuckNorris.fact
    @game = Game.new
    @my_teams = current_player.teams
    @other_teams = Team.exclude_player_teams(current_player.teams)
  end

  def create
    team_ids = game_params[:team_ids]
    @game = Game.new(team_ids: team_ids)

    if @game.save && Results::Result.new(@game).set_winner(team_ids.first, team_ids.second)
      WinnerMailer.email_losers(@game).deliver_now
      flash[:notice] = 'Your game won\'t show on the leaderboard until the losers confirm this result' unless player_is_loser?
      redirect_to root_path
    else
      flash[:alert] = @game.errors.full_messages.to_sentence
      redirect_to games_new_path
    end
  end

  def index
    @games = current_player.games
  end

  def show
    if (@game.has_no_winner? && player_in_game?) || (@game.has_winner? && @game.un_confirmed? && player_is_loser?)
      redirect_to(edit_games_path(id: params[:id]))
    end
  end

  def edit
    redirect_to winners_edit_path({ id: @game.winner.id }) if @game.un_confirmed?
  end

  def destroy
    if @game.destroy
      flash[:success] = 'Game deleted'
      redirect_to games_index_path
    end
  end

  private

  def game_params
    params.require(:game).permit(:id, :team_id, :winner, :team_ids => [])
  end

  def game_completed
    has_winner_and_player_is_winner = @game.has_winner? && !player_is_loser?

    return unless has_winner_and_player_is_winner || @game.completed?

    flash[:notice] = 'That game already has a winner'
    redirect_to games_index_path
  end

  def redirect_if_player_not_in_game
    redirect_to games_index_path unless player_in_game?
  end

  def select_team
    @winning_team = @game.teams.find { |team| team.id == game_params[:winner].to_i }
  end
end
