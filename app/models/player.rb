# frozen_string_literal: true

# Player (user) model
class Player < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_and_belongs_to_many :teams
  has_many :games, through: :teams
  has_many :winner, through: :teams
  has_many :loser, through: :teams

  devise :registerable, :rememberable
  devise :omniauthable, omniauth_providers: [:github]

  scope :exclude_current_player, ->(signed_in_player) {
    where.not(id: signed_in_player.id)
  }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |player|
      player.email = auth.info.email
      player.name = auth.info.name   # assuming the player model has a name
      player.image = auth.info.image # assuming the player model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # player.skip_confirmation!
    end
  end

  def update_played_won_lost
    update_attributes(
      played: games.count,
      won: winner.count,
      lost: loser.count,
      average: (winner.count.to_f / games.count.to_f) * 100.round(2)
    )
  end

  def team_name
    name
  end

  # Un comment and customise when you want to use data (image etc) from oauth provider
  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
  #       user.email = data["email"] if user.email.blank?
  #     end
  #   end
  # end
end
