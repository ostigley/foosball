module Results
  class Result
    def initialize(game, winner)
      @game = game
      @winner = winner
      @loser = @game.teams.find {|team| team != @winner }
    end

    def set_winner
      @game.create_winner(team: @winner)
      @game.create_loser(team: @loser)
      @game.save!
    end
  end
end
