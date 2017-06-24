require 'rails_helper'

RSpec.feature 'New game page', type: :feature do
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
      @teams = create_list(:team, 3, :full_team)
      set_omniauth(signed_in_player)
      sign_in_page.load
      sign_in_page.github.click
      new_game_page.load
    end

    scenario 'loads the new team form' do
      expect(new_game_page).to have_form_container
    end

    context 'the new team form' do
      scenario 'renders the list of teams' do
        expect(page).to have_content(@teams.first.team_name)
        expect(page).to have_content(@teams.second.team_name)
      end
    end

    context 'createing a new team' do
      scenario 'renders the teams index page' do
        new_game_page.teams[0].click
        new_game_page.teams[2].click
        new_game_page.submit.click

        expect(page.current_path).to match '/games?'
      end
    end
  end
end
