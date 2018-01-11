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

  after_save do
    players.each(&:update_played_won_lost)
    teams.each(&:update_played_won_lost)
  end

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

  [:loser, :winner].each do |relationship|
    # loser_players && winner_players
    define_method("#{relationship}_players".to_sym) do
      send(relationship).team.players
    end

    # loser_team_name && winner_team_name
    define_method("#{relationship}_team_name".to_sym) do
      send(relationship).team.team_name
    end

    # has_no_winner? && has_no_loser?
    define_method("has_no_#{relationship}?".to_sym) do
      send(relationship).nil?
    end

    # has_winner? && has_loser?
    define_method("has_#{relationship}?".to_sym) do
      send(relationship).present?
    end
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
