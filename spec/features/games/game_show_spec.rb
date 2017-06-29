require 'rails_helper'

RSpec.feature 'Updating a game', type: :feature do
  let(:edit_game_page) { EditGame.new }
  let(:sign_in_page) { SignInPage.new }
  let(:game_page) { GamePage.new }
  let(:game) { create(:game) }
  let(:players) { create_list(:player, 4) }

  context 'Viewing a game with no winner' do
    context 'that the signed in player did not play' do
      before do
        signed_in_player = create(:player)
        set_omniauth(signed_in_player)

        sign_in_page.load
        sign_in_page.github.click
        game_page.load(id: game.id)
      end

      scenario 'do not display a winner' do
        expect(game_page).to have_game
        expect(game_page).to_not have_game_winner
      end

    end

    context 'that the signed in player did play' do
      scenario 'redirects the edit game page' do
        signed_in_player = game.players.first
        set_omniauth(signed_in_player)
        sign_in_page.load
        sign_in_page.github.click
        game_page.load(id: game.id)

        expect(edit_game_page).to have_edit_game_form
        expect(edit_game_page.loaded?).to eq true
      end
    end
  end

  context 'Viewing a game with an unconfirmed winner' do
    context 'that the signed in player did not play' do
      before do
        game.create_winner(team: game.teams.first)
        signed_in_player = create(:player)
        set_omniauth(signed_in_player)

        sign_in_page.load
        sign_in_page.github.click
        game_page.load(id: game.id)
      end

      scenario 'shows that the win is unconfirmed' do
        expect(game_page).to have_winner_unconfirmed
      end

    end
  end
end