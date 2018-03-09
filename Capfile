require "capistrano/setup"

require "capistrano/deploy"

require 'capistrano/bundler'
require 'capistrano/rails/assets' # for asset handling add
require 'capistrano/rails/migrations' # for running migrations
require 'capistrano/puma'#


require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git


Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
