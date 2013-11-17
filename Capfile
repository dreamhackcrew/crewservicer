# Built-in recipes
load 'deploy'
load 'deploy/assets'

# Bundler
require 'bundler/capistrano'

# Custom recipes
Dir.glob('lib/recipes/*.rb').each { |r| load r }

# Config
load 'config/deploy'

# New Relic
require 'new_relic/recipes'
