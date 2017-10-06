class WinnerMailer < ApplicationMailer
  default_url_options[:host]

  def email_losers(game)
    @game = game
    @losers = @game.loser_players
    @winners = @game.winner_team_name

    mail(to: @losers.map(&:email), subject: 'Foosball loser confirmation')
  end
end