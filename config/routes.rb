Rails.application.routes.draw do
  get 'games/new'

  get 'games/index'

  devise_for :players, :controllers => { :omniauth_callbacks => "players/omniauth_callbacks" }

  devise_scope :player do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_player_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_player_session
  end

  # devise_for :players, :controllers => { :omniauth_callbacks => "players/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "games#index"
end
