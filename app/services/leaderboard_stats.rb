module LeaderboardStats
  class Leaderboard
    def initialize(teams = nil, games = nil, players = nil)
      @teams = teams
      @games = games
      @players = players
    end

    def team_leaderboard
      leaderboard = []
      @teams.map do |team|
        played = team.games.count(&:winner)
        won = team.winner.count
        lost = team.loser.count

        leaderboard << {
          name: team.team_name,
          played: played,
          won: won,
          lost: lost,
          average: won > 0 ? (played / won)*100 : 0
        }
      end

      leaderboard.sort! do |a,b|
        if b[:won] == a[:won] && a[:played] != 0
          a[:played] <=> b[:played]
        elsif a[:played] != 0
          b[:won] <=> a[:won]
        else
          1
        end
      end
    end

    def player_leaderboard

    end
  end
end
