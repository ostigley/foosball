# This file is copied to spec/ when you run 'rails generate rspec:install'

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production? || Rails.env.development?
require 'rspec/rails'
require "selenium/webdriver"
require 'capybara'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'
require 'site_prism'

ActiveRecord::Migration.maintain_test_schema!


Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w(headless disable-gpu) }
  )

  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    desired_capabilities: capabilities
end

Capybara.javascript_driver = :chrome



Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  "screenshot_#{example.description.tr(' ', '-').gsub(%r{^.*\/spec\/}, '')}"
end
Capybara::Screenshot.prune_strategy = :keep_last_run
Capybara.asset_host = 'http://localhost:3000'

# Cannot get webkit/selenium working on the Gitlab-CI so using PhantomJS
# This is definitely going to cause some weird test failures in the future I'm sure, but yolo

RSpec.configure do |config|

  # Include site prism page objects
  Dir[Rails.root.join('spec/page_objects/**/*.rb')].sort { |path| path.include?('shared') ? 0 : 1 }
                                                 .each { |f| require f }

  Dir[Rails.root.join('spec/support/*.rb')].each { |f| require f }
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
