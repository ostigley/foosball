# Winner Model
class Winner < ApplicationRecord
  has_secure_token
  belongs_to :game
  belongs_to :team
end