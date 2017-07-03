module Results
  class Result
    def initialize(game)
      @game = game
    end

    def set_winner(winner)
      loser = @game.teams.find {|team| team != winner }
      @game.create_winner(team: winner)
      @game.create_loser(team: loser)
      @game.save!
    end

    def confirm_winner(winner, confirmation)
      winner.confirmed = confirmation
      winner.save!
    end
  end
end
