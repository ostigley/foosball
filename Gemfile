source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.1'
gem 'sass-rails', '~> 5.0'
gem 'sqlite3'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'haml-rails'
gem 'jbuilder', '~> 2.5'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'turbolinks', '~> 5'
gem 'pry'
group :development, :test do
  gem 'capybara', '~> 2.13'
  gem 'factory_girl_rails'
  gem 'faker', branch: 'master', git: 'https://github.com/stympy/faker.git'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
