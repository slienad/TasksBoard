# config valid only for Capistrano 3.1
lock '3.1.0'

# config valid only for Capistrano 3.1


set :application, "TasksBoard"


# Default value for :format is :pretty
set :format, :pretty

set :repo_url, 'https://github.com/slienad/TasksBoard.git'

# Default deploy_to directory is /var/www/my_app
set :deploy_to,  "/home/deployer/apps/Tasksboard"

set :ssh_options, {
  forward_agent: true,
  port: 3456
}


# Default value for :log_level is :debug
set :log_level, :debug



SSHKit.config.command_map[:rake]  = "bundle exec rake" #8
SSHKit.config.command_map[:rails] = "bundle exec rails"

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join("tmp/restart.txt")
    end
  end

  after :finishing, "deploy:cleanup"
  
  desc "Set up configuration"
  task :setup_config do
  	on roles(:app), in: :sequence, wait: 5 do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    puts "Check config files in #{shared_path}."
    end
  end
  after "deploy:setup", "deploy:setup_config"



end