require 'rails_helper'

RSpec.feature 'Viewing a game', type: :feature do
  let(:edit_game_page) { EditGame.new }
  let(:sign_in_page) { SignInPage.new }
  let(:game_page) { GamePage.new }
  let(:game) { create(:game) }
  let(:players) { create_list(:player, 4) }

  context 'that has no winner' do
    context 'which I did not play' do
      before do
        signed_in_player = create(:player)
        set_omniauth(signed_in_player)

        sign_in_page.load
        sign_in_page.github.click
        game_page.load(id: game.id)
      end

      scenario 'does not display a winner' do
        expect(game_page).to have_game
        expect(game_page).to_not have_game_winner
      end

    end

    context 'that that I played' do
      scenario 'redirects me to the edit game page' do
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

  context 'that has an unconfirmed winner' do
    before do
      game.create_winner(team: game.teams.first)
      signed_in_player = create(:player)
      set_omniauth(signed_in_player)

      sign_in_page.load
      sign_in_page.github.click
      game_page.load(id: game.id)
    end

    scenario 'shows that the win/loss is unconfirmed' do
      expect(game_page).to have_winner_unconfirmed
    end

  end

  context 'that I lost but have not confirmed' do

    scenario 'redirects me to the game edit page' do
      game.create_winner(team: game.teams.first)
      game.create_loser(team: game.teams.second)

      signed_in_player = game.teams.second.players.first

      set_omniauth(signed_in_player)

      sign_in_page.load
      sign_in_page.github.click
      game_page.load(id: game.id)
      expect(edit_game_page.loaded?).to eq true
    end
  end
end































