# Game Model
class Game < ApplicationRecord
  has_one :winner
  has_one :loser
  has_and_belongs_to_many :teams
  validates_associated :teams
  validates :teams, length: { is: 2,
                              message: 'A game needs exactly two teams' }
  validate :unique_players

  def players
    teams.map(&:players).flatten
  end

  def unique_players
    return if players.uniq.length == players.length
    errors.add(:teams, 'must have a unique set of players')
  end
end
