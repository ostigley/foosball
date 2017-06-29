class GamePage < SitePrism::Page
  set_url '/games{?id*}'

  element :game, '.game-show'
  element :game_winner, '.game-show__winner'
  element :winner_unconfirmed, '.game-show__unconfirmed'
end