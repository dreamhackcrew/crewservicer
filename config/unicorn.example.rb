listen '/path/to/app/tmp/sockets/unicorn.sock'
worker_processes 4
pid '/path/to/app/tmp/pids/unicorn.pid'
stderr_path '/path/to/app/log/unicorn.log'
stdout_path '/path/to/app/log/unicorn.log'
preload_app true

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)
end
