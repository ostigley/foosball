# Winners controller
class WinnersController < ApplicationController
  include Results
  before_action :require_login
  before_action :find_winner, only: [:edit, :update]
  before_action :find_winning_game, only: [:edit, :update]
  before_action :game_needs_update, only: [:edit, :update]

  def edit
  end

  def update
    confirmation = winner_params[:confirmed]
    if Results::Result.new(@game).confirm_winner(@winner, confirmation)
      redirect_to root_path
      flash[:notice] = "The leader board has been updated with your loss"
    end
  end

  private

  def winner_params
    params.require(:winner).permit(:confirmed)
  end

  def find_winner
    @winner ||= Winner.find_by_id(params[:id])
  end

  def game_needs_update
    redirect_to root_path unless (!@winner.confirmed? && player_is_loser?)
    flash[:notice] = 'Only a loser can confirm the game winner'
  end

  def find_winning_game
    @game = @winner.game
  end

end