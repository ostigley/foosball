# Game Model
class Game < ApplicationRecord
  has_one :winner
  has_one :loser
  has_and_belongs_to_many :teams
  validates_associated :teams
  validates :teams, length: { is: 2,
                              message: 'A game needs exactly two teams' }
  validate :unique_players

  before_destroy :delete_wins_losses

  def delete_wins_losses
    winner.delete unless has_no_winner?
    loser.delete unless has_no_loser?
  end

  def unique_players
    return if players.uniq.length == players.length
    errors.add(:teams, 'must have a unique set of players')
  end

  def players
    teams.map(&:players).flatten
  end

  def winning_players
    winner.team.players
  end

  def losing_players
    loser.team.players
  end

  def has_no_winner?
    winner.nil?
  end

  def has_no_loser?
    loser.nil?
  end

  def has_winner?
    winner.present?
  end

  def has_loser?
    loser.present?
  end

  def completed?
    has_winner? && confirmed?
  end

  def confirmed?
    has_winner? && winner.confirmed
  end

  def un_confirmed?
    has_winner? && !winner.confirmed
  end
end
