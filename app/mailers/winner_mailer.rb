# frozen_string_literal: true

class WinnerMailer < ApplicationMailer
  default_url_options[:host]

  def email_losers(game)
    @game = game
    @losers = @game.loser_players
    @winners = @game.winner_team_name
    @loser_giphy = Giphy.search('loser', limit: 100).sample.original_image.url

    mail(to: @losers.map(&:email), subject: 'Foosball loser confirmation')
  end
end
