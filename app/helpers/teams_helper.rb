module TeamsHelper
  def team_name(team)
    "#{team.players.first.name} & #{team.players.second.name}"
  end
end
