require 'rails_helper'

RSpec.feature 'Updating a game', type: :feature do
  let(:edit_game_page) { EditGame.new }
  let(:sign_in_page) { SignInPage.new }
  let(:players) { create_list(:player, 4)}
  let(:team1) { create(:team, players: [players.first, players.second]) }
  let(:team2) { create(:team, players: [players.third, players.fourth]) }
  let(:game) { create(:game, teams: [team1, team2]) }

  context 'for non-logged in players' do
    scenario 'redirects to sign in page' do
      edit_game_page.load({id: 1})
      expect(current_path).to eq new_player_session_path
    end
  end

  context 'for players that did not play' do
    scenario 'redirects to the games index page' do
      game
      signed_in_player = create(:player)
      set_omniauth(signed_in_player)
      sign_in_page.load
      sign_in_page.github.click
      edit_game_page.load({id: game.id})

      expect(current_path).to eq games_index_path
    end
  end
 end
