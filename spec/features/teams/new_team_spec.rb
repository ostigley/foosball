require "rails_helper"

RSpec.feature 'New team page', type: :feature do
  let(:new_team_page) { NewTeam.new }
  let(:player) { create(:player) }

  # before do
  #   foosball.login.load

  #   within kereru.login.login_form do
  #     fill_in 'user[login]', with: user.username
  #     fill_in 'user[password]', with: user.password
  #     click_button 'Sign in'
  #   end

  #   kereru.my_stories.load

    context 'for non-logged in users' do
      scenario 'redirects to sign in page' do
        new_team_page.load
        expect(current_path).to eq new_player_session_path
      end
    end
  end
