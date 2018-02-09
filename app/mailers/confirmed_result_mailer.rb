class ConfirmedResultMailer < ApplicationMailer
  default_url_options[:host]

  def email_winners(game)
    @losers = game.loser_team_name
    @winner_giphy = Giphy.search('winner', {limit: 100}).sample.original_image.url
    winners = game.winner_players

    mail(to: winners.map(&:email), subject: 'Foosball win confirmation')
  end
end
