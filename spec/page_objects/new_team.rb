class NewTeam < SitePrism::Page
  set_url '/teams/new'

  element :header, 'h1#new-team-page-header'
  element :form_container, '#new-team-form'
  elements :players, 'div input'
  element :submit_button, 'input#submit-new-team'
end