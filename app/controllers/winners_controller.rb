# frozen_string_literal: true

# Winners controller
class WinnersController < ApplicationController
  include Results
  before_action :require_login, only: %i[edit update]
  before_action :winner, only: %i[edit update]
  before_action :find_winning_game, only: %i[edit update]
  before_action :game_needs_update, only: %i[edit update]

  def edit; end

  def update
    confirmation = winner_params[:confirmed]
    if Results::Result.new(@game).confirm_winner(@winner, confirmation)
      redirect_to root_path
      flash[:notice] = 'The leader board has been updated with your loss'
    else
      redirect_to winners_edit_path(id: @winner.id)
    end
  end

  def confirmation_token
    @winner = Winner.find_by_token(winner_params[:token])

    if @winner && Results::Result.new(@winner.game).confirm_winner(@winner, true)
      ConfirmedResultMailer.email_winners(@winner.game).deliver_now
      flash[:success] = 'Thanks for confirming.  The leaderboard has been updated.'
    else
      flash[:alert] = 'I couldn\'t find that game sorry.'
    end
    redirect_to root_path
  end

  private

  def winner_params
    params.require(:winner).permit(:confirmed, :token)
  end

  def winner
    @winner ||= Winner.find_by_id(params[:id])
  end

  def game_needs_update
    redirect_to root_path unless !@winner.confirmed? && player_is_loser?
  end

  def find_winning_game
    @game = @winner.game
  end
end
