# Winners controller
class WinnersController < ApplicationController
  include Results
  before_action :require_login, only: [:edit, :update]
  before_action :find_winner, only: [:edit, :update]
  before_action :find_winning_game, only: [:edit, :update]
  before_action :game_needs_update, only: [:edit, :update]

  def edit
  end

  def update
    confirmation = winner_params[:confirmed]
    if Results::Result.new(@game).confirm_winner(@winner, confirmation)
      redirect_to root_path
      flash[:notice] = 'The leader board has been updated with your loss'
    end
  end

  def confirmation_token
    @winner = Winner.find_by_token(winner_params[:token])

    if @winner && @winner.try(:confirm)
      flash[:success] = 'Thanks for confirming.  The leaderboard has been updated'
    else
      flash[:alert] = 'I couldn\'t find that game sorry.'
    end
    redirect_to root_path
  end

  private

  def winner_params
    params.require(:winner).permit(:confirmed, :token)
  end

  def find_winner
    @winner ||= Winner.find_by_id(params[:id])
  end

  def game_needs_update
    redirect_to root_path unless (!@winner.confirmed? && player_is_loser?)
  end

  def find_winning_game
    @game = @winner.game
  end

end