# Winner Model
class Winner < ApplicationRecord
  belongs_to :game
  belongs_to :team
end