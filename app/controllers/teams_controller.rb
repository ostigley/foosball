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

  def team_options
    team1 = Team.find_by_id(team_params[:id])
    teams = Team.team_options(team_params[:id])

    available_players = teams.map(&:players).flatten.map do |player|
      {
        id: player.id,
        name: player.name
      }
    end

    render json: available_players.flatten.uniq, status: 200
  end


  private

  def team_params
    params.require(:team).permit(:player_ids, :id)
  end

  def team_players(team)
    team.players.map do |player|
      {
        id: player.id,
        team: team.id
      }
    end
  end
end
