require 'rails_helper'

RSpec.feature 'Updating a game', type: :feature do
  let(:edit_game_page) { EditGame.new }
  let(:edit_winner_page) { WinnerEdit.new }
  let(:sign_in_page) { SignInPage.new }
  let(:game_page) { GamePage.new }

  context 'when I\' not logged in' do
    scenario 'redirects me to the sign in page' do
      edit_game_page.load(id: 1)
      expect(current_path).to eq new_player_session_path
    end
  end

  context 'when I\m logged in' do
    before do
      @game = create(:game)
    end
    context 'but did not participate in the game' do
      scenario 'redirects me to the games index page' do
        signed_in_player = create(:player)
        set_omniauth(signed_in_player)

        sign_in_page.load
        sign_in_page.github.click
        edit_game_page.load(id: @game.id)

        expect(current_path).to eq games_index_path
      end
    end

    context 'and participted in the game' do
      before do
        # Make the signed in player part of the team
        @signed_in_player = @game.players.first
        set_omniauth(@signed_in_player)

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

      context 'and claim a win' do
        before do

          my_team_label = find(:css, "input#game_winner_#{@game.teams.first.id}")
          my_team_label.set true

          expect { edit_game_page.submit_button.click }.to change{ActionMailer::Base.deliveries.count}.by 1
        end

        scenario 'redirects me to the games path with 200 status code' do
          expect(page.status_code).to eq 200
          expect(page.current_path).to eq games_path
        end

        scenario 'renders the game container and shows a winner' do
          expect(game_page.loaded?).to be true
          expect(game_page).to have_game
          expect(game_page).to have_game_winner
        end
      end

      context 'and claim a loss' do
        before do

          winning_team_label = find(:css, "input#game_winner_#{@game.teams.second.id}")
          winning_team_label.set true

          expect { edit_game_page.submit_button.click }.to change{ActionMailer::Base.deliveries.count}.by 1
        end

        scenario 'redirects me to the games path with 200 status code' do
          expect(page.status_code).to eq 200
          expect(page.current_path).to eq winners_edit_path
        end

        scenario 'renders the winner confirmation form' do
          expect(edit_winner_page.loaded?).to be true
        end
      end

      scenario 'lets the player confirm the winner'
    end

    context 'for games that already have a winner' do
      before do
        @game.create_winner(team: @game.teams.first)
        @game.create_loser(team: @game.teams.second)

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
