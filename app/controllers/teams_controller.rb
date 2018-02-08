class TeamsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @team = Team.new
    @players = Player.exclude_current_player current_player
  end

  def create
    @team = Team.new
    @team.players = [current_player]
    @team.players << Player.find_by_id(team_params[:player_ids])
    @team.identifier = @team.generate_identifier

    if @team.save!
      redirect_to teams_path
    else
      render :new
    end
  end

  def index
    @teams = Team.all
  end

  private

  def team_params
    params.require(:team).permit(:player_ids)
  end
end
