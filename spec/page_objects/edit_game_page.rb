class EditGame < SitePrism::Page
  set_url '/games/edit{?id*}'

  element :edit_game_form, '.edit-game-form'
  elements :winner_radio_buttons, '.edit-game-form__radio-buttons'
  element :submit_button, '#submit'
end
