
def set_omniauth(player)
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
    provider: 'github',
    uid: player.uid,
    info: {
      email: player.email,
      image: 'https://avatars1.githubusercontent.com/u/10747958?v=3',
      name: player.name
    }
  )
  Rails.application.env_config['devise.mapping'] = Devise.mappings[:player]
  Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
end
