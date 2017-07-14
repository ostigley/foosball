module Results
  class Result
    def initialize(game)
      @game = game
    end

    def set_winner(winner_id, loser_id)
      @game.create_winner(team_id: winner_id)
      @game.create_loser(team_id: loser_id)
      @game.save!
    end

    def confirm_winner(winner, confirmation)
      winner.confirmed = confirmation
      winner.save!
    end
  end
end
