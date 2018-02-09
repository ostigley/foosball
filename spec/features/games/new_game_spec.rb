require 'rails_helper'

RSpec.feature 'New game page', type: :feature, js: true do
  let(:new_game_page) { NewGame.new }
  let(:sign_in_page) { SignInPage.new }
  let(:player_without_a_team) { create(:player) }
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
        expect(new_game_page).to have_my_teams_players count: 2
      end

      scenario 'chosing a team mate renders a unique list of possible opposing players' do
        expect(new_game_page.other_player_1.count).to eq 1
        new_game_page.my_team_select.select(Player.first.name)
        sleep 1

        expect(new_game_page.other_player_1.count).to eq 7 # 6 players plus the instruction

        unique_check = new_game_page.other_player_1.map(&:text).uniq.length == new_game_page.other_player_1.length
        expect(unique_check).to be true
      end
    end

    context 'creating a new game' do
      context 'creating a new game that i won' do
        before do
          new_game_page.my_team_select.select(Player.first.name)
          sleep 1
          new_game_page.other_player_1_select.select(new_game_page.other_player_1.last.text)
          sleep 1
          new_game_page.other_player_2_select.select(new_game_page.other_player_2.last.text)

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
          winner_players = Game.first.winner_players
          expect(winner_players.include?(signed_in_player)).to eq true
        end
      end


      # context 'against a team that doesn\'t exist' do

      #   before do
      #     player_without_a_team.save
      #     puts '****'
      #     puts player_without_a_team.name

      #     new_game_page.my_team_select.select(Player.first.name)
      #     sleep 1
      #     new_game_page.other_player_1_select.select(new_game_page.other_player_1.second.text)

      #     new_game_page.other_player_2_select.select(player_without_a_team.name)

      #     # expect { new_game_page.submit_button.click }.to change{ActionMailer::Base.deliveries.count}.by 1
      #   end

      #   scenario 'generates a new team for that player' do
      #     expect(player_without_a_team.teams).to eq 1
      #   end

      #   scenario 'renders the root path' do
      #     expect(page.current_path).to eq root_path
      #   end

      #   scenario 'creates a game on the db' do
      #     expect(Game.count).to eq 1
      #     expect(Game.first.has_winner?).to eq true
      #   end

      #   scenario 'sets a game winner to my team' do
      #     winner_players = Game.first.winner_players
      #     expect(winner_players.include?(signed_in_player)).to eq true
      #   end
      # end
    end
  end
end
