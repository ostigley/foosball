# frozen_string_literal: true

module GamesHelper
  def my_team_options
    @my_teams.map do |team|
      other_player = team.players.find { |player| player != current_player }

      [other_player.name, team.id, { 'data-player-id': other_player.id }]
    end
  end

  def other_player_options
    @other_players.map { |player| [player.name, player.id] }
  end
end
