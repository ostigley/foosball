require 'rails_helper'

RSpec.feature 'Updating a game', type: :feature do
  let(:edit_game_page) { EditGame.new }
  let(:sign_in_page) { SignInPage.new }
  let(:signed_in_player) { create(:player) }

  context 'for non-logged in players' do
    scenario 'redirects to sign in page' do
      edit_game_page.load(id: 1)
      expect(current_path).to eq new_player_session_path
    end
  end

  context 'for logged in players' do

    context 'for players that did not play' do
      scenario 'redirects to the games index page' do
        @game = create(:game)
        set_omniauth(signed_in_player)

        sign_in_page.load
        sign_in_page.github.click
        edit_game_page.load(id: @game.id)

        expect(current_path).to eq games_index_path
      end
    end

    context 'for players that did play in the game' do
      scenario 'renders the update game form' do
      end

      scenario 'lets the player set a winner' do
      end

      scenario 'lets the player confirm the winner' do
      end
    end
  end
 end
