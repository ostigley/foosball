# Player (user) model
class Player < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_and_belongs_to_many :teams

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


  # Un comment and customise when you want to use data (image etc) from oauth provider
  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
  #       user.email = data["email"] if user.email.blank?
  #     end
  #   end
  # end
end
