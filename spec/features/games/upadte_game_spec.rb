require 'rails_helper'

RSpec.feature 'Updating a game', type: :feature do
  let(:edit_game_page) { EditGame.new }
  let(:sign_in_page) { SignInPage.new }
  let(:game_page) { GamePage.new }

  context 'for non-logged in players' do
    scenario 'redirects to sign in page' do
      edit_game_page.load(id: 1)
      expect(current_path).to eq new_player_session_path
    end
  end

  context 'for logged in players' do
    before do
      @game = create(:game)
    end
    context 'for players that did not play' do
      scenario 'redirects to the games index page' do
        signed_in_player = create(:player)
        set_omniauth(signed_in_player)

        sign_in_page.load
        sign_in_page.github.click
        edit_game_page.load(id: @game.id)

        expect(current_path).to eq games_index_path
      end
    end

    context 'for players that did play in the game' do
      before do
        # Make the signed in player part of the team
        signed_in_player = @game.players.first
        set_omniauth(signed_in_player)

        sign_in_page.load
        sign_in_page.github.click
        edit_game_page.load(id: @game.id)
      end

      scenario 'renders the update game form' do
        expect(edit_game_page).to have_edit_game_form
      end

      scenario 'renders the team names' do
        expect(edit_game_page).to have_content(@game.teams.first.team_name)
        expect(edit_game_page).to have_content(@game.teams.second.team_name)
      end

      context 'Winning player claims a win and' do
        before do
          winner_button = edit_game_page.winner_radio_buttons.last
          winner_button.click
          edit_game_page.submit_button.click
        end

        scenario 'lets the winning player claim a win' do
          expect(page.status_code).to eq 200
          expect(page.current_path).to eq games_path
        end

        scenario 'updating the game redirects to the game show page' do
          expect(game_page.loaded?).to be true
          expect(game_page).to have_game
          expect(game_page).to have_game_winner
        end
      end

      scenario 'lets the player confirm the winner'
    end

    context 'for games that already have a winner' do
      before do
        @game.create_winner(team: @game.teams.first)
        signed_in_player = @game.players.first
        set_omniauth(signed_in_player)

        sign_in_page.load
        sign_in_page.github.click
        edit_game_page.load(id: @game.id)
      end
      scenario 'redirects to game index if a game already has a winner' do
        expect(page.current_path).to eq games_index_path
      end

      scenario 'show flash  message if a game already has a winner' do
        expect(page).to have_content 'That game already has a winner'
      end
    end
  end
 end
