class WinnerMailer < ApplicationMailer

  def email_losers(game)
    @game = game
    @losers = @game.losing_players
    @winners = @game.winning_team_name
    

    mail(to: @losers.map(&:email), subject: 'Foosball loser confirmation')
  end
end