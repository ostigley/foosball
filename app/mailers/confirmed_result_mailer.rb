class ConfirmedResultMailer < ApplicationMailer
  default_url_options[:host]

  def email_winners(game)
    @losers = game.losing_team_name
    winners = game.winning_players

    mail(to: winners.map(&:email), subject: 'Foosball win confirmation')
  end
end