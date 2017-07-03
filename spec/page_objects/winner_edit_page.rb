# winner page object
class WinnerEdit < SitePrism::Page
  set_url '/winners/edit{?id*}'

  element :winner_form, '.edit-winner-form'
  element :yes_button, 'input#winner_confirmed_true'
  element :no_button, 'input#winner_confirmed_false'
  element :submit_button, 'input#submit'
end