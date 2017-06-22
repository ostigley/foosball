module TeamsHelper
  def team_name(team)
    "#{team.players.first.name} & #{team.players.second.name}"
  end

  def game_name(game)
    "<p>#{game.teams.first.team_name}</p>
    <p>|Vs|</p>
    <p>#{game.teams.second.team_name}</p>".html_safe
  end
end
