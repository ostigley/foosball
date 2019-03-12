# frozen_string_literal: true

# Team model
class Team < ApplicationRecord
  has_many :winner
  has_many :loser
  has_and_belongs_to_many :games
  has_and_belongs_to_many :players

  validates_associated :players
  validates :players, length: { is: 2,
                                message: 'A team needs exactly two players' }

  scope :exclude_player_teams, ->(signed_in_player_teams, teams = Team.all) {
    teams - signed_in_player_teams
  }

  scope :by_player_ids, ->(ids) do
    joins(:players).where(players: { id: ids }).group(:id).having('count(1) = ?', ids.count)
  end

  scope :team_options, ->(team_id) {
    team = find_by_id(team_id)
    players = team.players

    Team.exclude_player_teams([players.first.teams, players.second.teams].flatten)
  }

  def team_name
    "#{players.first.name} & #{players.second.name}"
  end
  alias name team_name

  def generate_identifier
    identifier = ''
    players.order(:email).map { |player| identifier << player.email }
    identifier
  end

  def image
    players.map(&:image).map { |image| "<img src=#{image}>" }.join(' ')
  end

  def update_played_won_lost
    update_attributes(
      played: games.count,
      won: winner.count,
      lost: loser.count,
      average: (winner.count.to_f / games.count.to_f) * 100.round(2)
    )
  end
end
