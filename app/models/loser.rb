# frozen_string_literal: true

# Loser Model
class Loser < ApplicationRecord
  belongs_to :game
  belongs_to :team

  def confirmed?
    game.winner.confirmed?
  end
end
