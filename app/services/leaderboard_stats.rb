module LeaderboardStats
  # Generate leaderboard data
  class Leaderboard
    def initialize(teams = nil, players = nil)
      @teams = teams
      @players = players
    end

    def team_leaderboard
      sort_leaderboard(leaderboard_hash(@teams))
    end

    def player_leaderboard
      sort_leaderboard(leaderboard_hash(@players))
    end

    private

    def leaderboard_hash(model_array)
      leaderboard = []
      model_array.map do |record|
        played = record.games.count(&:winner)

        next if played.zero?

        won = record.winner.count
        lost = record.loser.count

        leaderboard << {
          name: record.team_name,
          played: played,
          won: won,
          lost: lost,
          average: percentage(won, played)
        }
      end

      leaderboard
    end

    def sort_leaderboard(leaderboard)
      leaderboard.sort! do |a, b|
        if b[:won] == a[:won] && a[:played] != 0
          a[:played] <=> b[:played]
        elsif a[:played] != 0
          b[:won] <=> a[:won]
        else
          1
        end
      end
    end

    def percentage(a, b)
      ((a.to_f / b.to_f) * 100).round(2)
    end
  end
end