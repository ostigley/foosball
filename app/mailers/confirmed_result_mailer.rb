class ConfirmedResultMailer < ApplicationMailer
  default_url_options[:host]

  def email_winners(game)
    @losers = game.loser_team_name
    winners = game.winner_players

    mail(to: winners.map(&:email), subject: 'Foosball win confirmation')
  end
end