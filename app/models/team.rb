# Team model
class Team < ApplicationRecord
  has_and_belongs_to_many :games
  has_and_belongs_to_many :players

  validates_associated :players
  validates :players, length: { is: 2,
                                message: 'A team needs exactly two players' }
end
