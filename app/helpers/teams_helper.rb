module TeamsHelper
  def team_name(team)
    "#{team.players.first.name} & #{team.players.second.name}"
  end

  def game_name(game)
    "#{game.team.players.first.name} Vs #{game.team.players.second.name}"
  end
end
