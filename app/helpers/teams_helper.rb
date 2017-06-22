module TeamsHelper
  def team_name(team)
    "#{team.players.first.name} & #{team.players.second.name}"
  end

  def game_name(game)
    "#{game.teams.first.team_name} Vs #{game.teams.second.team_name}"
  end
end
