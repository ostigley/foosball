require 'rails_helper'

RSpec.feature 'Updating a game winner', type: :feature do
  let(:edit_winner_page) { WinnerEdit.new }
  let(:sign_in_page) { SignInPage.new }

  before do
    @game = create(:game)
  end

  context 'if I am part of the winning team' do
    before do
      signed_in_player = @game.players.first
      set_omniauth(signed_in_player)

      @game.create_winner(team: @game.teams.first)
      @game.create_loser(team: @game.teams.second)


      sign_in_page.load
      sign_in_page.github.click
      edit_winner_page.load(id: @game.winner.id)
    end

    scenario 'redirects to game index page' do
      expect(page.current_path).to eq root_path
    end

    scenario 'shows a flash message' do
      # expect(page).to have_content 'Only a loser can confirm the game winner'
    end
  end

  context 'if I am part of the losing team' do
    before do
      signed_in_player = @game.players.first
      set_omniauth(signed_in_player)

      @game.create_winner(team: @game.teams.second)
      @game.create_loser(team: @game.teams.first)

      sign_in_page.load
      sign_in_page.github.click
      edit_winner_page.load(id: @game.winner.id)
    end

    scenario 'renders the edit_winner form' do
      expect(edit_winner_page).to have_winner_form
    end

    context 'and I click "yes" to confirm my loss' do
      before do
        edit_winner_page.yes_button.click
        edit_winner_page.submit_button.click
        @game.reload
      end

      scenario 'updates the winner confirmation' do
        expect(@game.winner.confirmed).to eq true
      end

      scenario 'redirects me to the root path' do
        expect(page.current_path).to eq root_path
      end

      scenario 'shows a flash message confirming my loss' do
        expect(page).to have_content "The leader board has been updated with your loss"
      end
    end
  end

  context 'by email token link' do
    before do
      @email_count = ActionMailer::Base.deliveries.count
      @game.create_winner(team: @game.teams.second)
      @game.create_loser(team: @game.teams.first)
      # expect(ConfirmedResultMailer).to receive(:email_winners).with(@game)
      visit "#{root_url}winners/confirmation?winner[token]=#{@game.winner.token}"
    end

    scenario 'confirms the win on the winner instance' do
      @game.reload
      expect(@game.winner.confirmed).to eq true
    end

    scenario 'renders the leaderboard' do
      expect(page.current_path).to eq root_path
      expect(page).to have_content 'Thanks for confirming.  The leaderboard has been updated'
    end

    scenario 'sends an email to the losers' do
      expect(ActionMailer::Base.deliveries.count).to eq @email_count + 1
    end

    scenario 'increases winning team elo' do
      @game.reload
      expect(@game.winner.team.elo_ranking).to eq 1416
    end

    scenario 'decreases losing team elo' do
      @game.reload
      expect(@game.loser.team.elo_ranking).to eq 1384
    end

    scenario 'increases winning players elo' do
      @game.reload
      @game.winner_players.each do |player|
        expect(player.elo_ranking).to eq 1416
      end
    end

    scenario 'decreases losing players elo' do
      @game.reload
      @game.loser_players.each do |player|
        expect(player.elo_ranking).to eq 1384
      end
    end
  end
end