Rails.application.routes.draw do
  get 'games/new'
  get 'games/index'

  # Teams
  get 'teams/new', to: 'teams#new'
  post 'teams', to: 'teams#create'
  get 'teams', to: 'teams#index'

  # Games
  resource :games
  # get 'games/new', to: 'games#new'
  # post 'games', to: 'games#create'
  # get 'games', to: 'games#index'

  # Leadboards

  get 'leaderboard', to: 'leaderboards#index'

  devise_for :players, :controllers => { :omniauth_callbacks => "players/omniauth_callbacks" }

  devise_scope :player do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_player_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_player_session
  end

  root to: "games#index"
end
