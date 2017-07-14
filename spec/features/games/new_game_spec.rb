require 'rails_helper'

RSpec.feature 'New game page', type: :feature, js: true do
  let(:new_game_page) { NewGame.new }
  let(:sign_in_page) { SignInPage.new }

  let(:signed_in_player) { create(:player) }

  context 'for non-logged in users' do
    scenario 'redirects to sign in page' do
      new_game_page.load
      expect(current_path).to eq new_player_session_path
    end
  end

  context 'for logged in users' do
    before do
      @teams = create_list(:team, 5, :full_team)
      set_omniauth(signed_in_player)
      Team.last.players = [Player.first, signed_in_player]
      sign_in_page.load
      sign_in_page.github.click
      new_game_page.load
    end

    scenario 'loads the new team form' do
      expect(new_game_page).to have_form_container
    end

    context 'the new team form' do
      scenario 'renders the list of my teams' do
        expect(new_game_page).to have_my_teams count: 2
      end

      scenario 'renders the list of oposition teams' do
        expect(new_game_page.other_teams.count).to eq 5
      end
    end

    context 'creating a new game' do
      context 'selecting a team mate' do
        scenario 'removes all team mates other teams from the list' do
          expect(new_game_page.other_teams.count).to eq 5
          new_game_page.my_team_select.select(Player.first.name)
          expect(new_game_page.other_teams.count).to eq 4
        end
      end

      context 'creating a new game that i won' do
        before do
          new_game_page.my_team_select.select(Player.first.name)
          new_game_page.other_team_select.select(Team.second.team_name)
          expect { new_game_page.submit_button.click }.to change{ActionMailer::Base.deliveries.count}.by 1
        end

        scenario 'renders the root path' do
          expect(page.current_path).to eq root_path
        end

        scenario 'creates a game on the db' do
          expect(Game.count).to eq 1
          expect(Game.first.has_winner?).to eq true
        end

        scenario 'sets a game winner to my team' do
          winning_players = Game.first.winning_players
          expect(winning_players.include?(signed_in_player)).to eq true
        end
      end
    end
  end
end
