# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "lcguida"
set :repo_url, "git@github.com:lcguida/lcguida.github.io.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deploy/lcguida.com'

set :rvm_type, :user
set :rvm_ruby_version, '2.4.0@lcguida'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
namespace :deploy do

  after :publishing, :jekyll_build do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within current_path do
        execute :bundle, 'exec jekyll build'
      end
    end
  end

end