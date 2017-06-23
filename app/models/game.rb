# Game Model
class Game < ApplicationRecord
  has_one :winner
  has_one :loser
  has_and_belongs_to_many :teams
  validates_associated :teams
  validates :teams, length: { is: 2,
                              message: 'A game needs exactly two teams' }

  def players
    teams.map(&:players).flatten
  end
end
