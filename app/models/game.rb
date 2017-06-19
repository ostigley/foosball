# Game Model
class Game < ApplicationRecord
  has_and_belongs_to_many :teams
  validates_associated :teams
  validates :teams, length: { is: 2,
                              message: 'A game needs exactly two teams' }
end
