class NewGame < SitePrism::Page
  set_url '/games/new'

  element :header, 'h1#new-team-page-header'
  element :form_container, '#new-game-form'
  element :submit_button, 'input#submit-new-game'

  # Select boxes
  element :my_team_select, 'select.my-team'
  element :other_team_select, 'select.other-team'
  elements :my_teams_players, '.my-team option'

  element :other_player_1_select, 'select.other-player1'
  element :other_player_2_select, 'select.other-player2'

  elements :other_player_1, 'select.other-player1 option'
  elements :other_player_2, 'select.other-player2 option'
  elements :other_teams, 'select.other-team option'
  element :submit, '#submit-new-game'
end