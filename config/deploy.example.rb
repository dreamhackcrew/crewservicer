set :application, 'crewservicer'
set :repository,  'git://github.com/dreamhackcrew/crewservicer.git'
set :scm, :git

set :deploy_to, '/home/crewservicer/crewservicer/'
set :default_environment, { 'PATH' => '$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH' }

server 'host', :app, :web, :db, primary: true
set :port, 20
set :user, 'crewservicer'
set :use_sudo, false

set :shared_children, %w(public/system log tmp/pids tmp/sockets)

set :unicorn_binary, 'unicorn'
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

set :secrets_dir, 'secrets'
set :secret_files, {
  'database.yml'             => 'config',
  'unicorn.rb'               => 'config',
  'newrelic.yml'             => 'config',
  'crew_corner_oauth.rb'     => 'config/initializers',
  'secret_token.rb'          => 'config/initializers',
  'dreamhack_normal.*'       => 'app/assets/fonts',
  'dreamhack_thin.*'         => 'app/assets/fonts',
  'dreamhack-touch-icon.png' => 'app/assets/images'
}
