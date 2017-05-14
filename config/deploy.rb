# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "lcguida"
set :repo_url, "git@github.com:lcguida/lcguida.github.io.git"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deploy/lcguida.com'

set :rvm_type, :user
set :rvm_ruby_version, '2.4.0@lcguida'

namespace :deploy do

  task: :jekyll_build do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      within current_path do
        execute :bundle, 'exec jekyll build'
      end
    end
  end

end

# Run the jekyll build command after the release folder is created
after "symlink:release", "update_jekyll"
