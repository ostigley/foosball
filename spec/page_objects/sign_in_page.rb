class SignInPage < SitePrism::Page
  set_url '/sign_in'

  element :github, 'a#sign-in-with-github'
end