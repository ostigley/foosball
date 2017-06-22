class NewGame < SitePrism::Page
  set_url '/games/new'

  element :header, 'h1#new-team-page-header'
  element :form_container, '#new-game-form'
  elements :teams, 'div input'
  element :submit_button, 'input#submit-new-game'

  # Select boxes
  elements :teams, 'div.checkbox'
  element :submit, '#submit-new-game'
end