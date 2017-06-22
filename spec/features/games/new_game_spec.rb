require 'rails_helper'

RSpec.feature 'New game page', type: :feature do
  let(:new_game_page) { NewGame.new }
  let(:sign_in_page) { SignInPage.new }

  let(:signed_in_player) { create(:player) }
  let(:players) { create_list(:player, 5) }
  let(:team1) { create(:team, players: [players.first, players.second]) }
  let(:team2) { create(:team, players: [players.third, players.fourth]) }
  let(:team3) { create(:team, players: [signed_in_player, players.first]) }
  let(:game) { build(:game) }

  context 'for non-logged in users' do
    scenario 'redirects to sign in page' do
      new_game_page.load
      expect(current_path).to eq new_player_session_path
    end
  end

  context 'for logged in users' do
    before do
      set_omniauth(signed_in_player)
      sign_in_page.load
      sign_in_page.github.click
      [players, team1, team2, team3]
      new_game_page.load
    end

    scenario 'loads the new team form' do
      expect(new_game_page).to have_form_container
    end

    context 'the new team form' do
      scenario 'renders the list of teams' do
        expect(page).to have_content(team1.team_name)
        expect(page).to have_content(team2.team_name)
      end
    end

    context 'createing a new team' do
      scenario 'renders the teams index page' do
        new_game_page.teams[0].click
        new_game_page.teams[2].click
        new_game_page.submit.click

        expect(page.current_path).to match '/games?'
        # expect(page).to have_content("#{signed_in_player.name} & #{players.first.name}")
      end
    end
  end
end
