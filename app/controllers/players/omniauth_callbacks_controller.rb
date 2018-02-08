# Where we handle github and google oauth
class Players::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    binding.pry
    # You need to implement the method below in your model (e.g. app/models/player.rb)
    @player = Player.from_omniauth(request.env["omniauth.auth"])

    if @player.persisted?
      sign_in_and_redirect @player, :event => :authentication #this will throw if @player is not activated

      set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_player_registration_url
    end
  end

    def failure
      binding.pry
      redirect_to root_path
    end
end
