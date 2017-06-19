class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def new_session_path(scope)
    new_player_session_path
  end

  def require_login
    redirect_to new_player_session_path unless player_signed_in?
  end

  def team_has_current_player?(team)
    team.players.include? current_player
  end
end
