set(:secrets_path) { File.join(deploy_to, secrets_dir) }

namespace :deploy do
  task :symlink_secrets, :roles => :app, :except => { :no_release => true } do
    commands = []

    secret_files.each do |file, target_dir|
      commands << "ln -s -- #{secrets_path}/#{file} #{release_path}/#{target_dir}"
    end

    run commands.join(" && ") if commands.any?
  end
end

after 'deploy:finalize_update', 'deploy:symlink_secrets'