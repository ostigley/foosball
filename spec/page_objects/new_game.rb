class NewGame < SitePrism::Page
  set_url '/games/new'

  element :header, 'h1#new-team-page-header'
  element :form_container, '#new-game-form'
  element :submit_button, 'input#submit-new-game'

  # Select boxes
  element :my_team_select, 'select.my-team'
  element :other_team_select, 'select.other-team'
  elements :my_teams, '.my-team option'
  elements :other_teams, 'select.other-team option'
  element :submit, '#submit-new-game'
end