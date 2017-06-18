class TeamsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @team = Team.new
    @players = Player.exclude_current_player current_player
  end

  def create

  end

  def index
    @teams = Team.all
  end

  private

  def require_login
    redirect_to new_player_session_path unless player_signed_in?
  end

end


# new: user must be signed in or direct to sign in page with flash message
# new: send all other players minus current player, and current players as player 1