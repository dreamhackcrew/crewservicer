listen './tmp/sockets/unicorn.sock'
worker_processes 4
pid './tmp/pids/unicorn.pid'
stderr_path './log/unicorn.log'
stdout_path './log/unicorn.log'