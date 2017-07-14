module GamesHelper
  def my_team_options
    @my_teams.map do |team|
      other_player = team.players.find { |player| player != current_player }

      [ other_player.name, team.id, {'data-player-id': other_player.id} ]
    end
  end

  def other_team_options
    @other_teams.map { |team| [team.team_name, team.id, {'data-player-ids': team.player_ids.to_s}] }
  end
end
