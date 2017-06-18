require "rails_helper"

RSpec.feature 'New team page', type: :feature do
  let(:new_team_page) { NewTeam.new }
  let(:sign_in_page) { SignInPage.new }
  let(:signed_in_player) { create(:player) }
  let(:players) { create_list(:player, 5) }

  context 'for non-logged in users' do
    scenario 'redirects to sign in page' do
      new_team_page.load
      expect(current_path).to eq new_player_session_path
    end
  end

  context 'for logged in users' do
    before do
      set_omniauth(signed_in_player)
      sign_in_page.load
      sign_in_page.github.click
      players
      new_team_page.load
    end

    scenario 'loads the new team form' do
      expect(new_team_page).to have_form_container
    end

    context 'the new team form' do
      scenario 'renders the list of players' do
        players.each do |player|
          expect(page).to have_content(player.name)
        end
      end
    end
  end
end
